# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Adventure::StartMutation, type: :query do
  let(:user) { create(:user) }
  let(:adventure) { create(:adventure, :complete, published: true).start(user) }
  let!(:step) { create(:adventure_step, adventure: adventure) }
  let(:attributes) do
    date_field = create(:adventure_step_form_field_date_field, :complete, step: step)
    number_field = create(:adventure_step_form_field_number_field, :complete, step: step)
    radio_field = create(:adventure_step_form_field_radio_field, :complete, step: step)
    string_field = create(:adventure_step_form_field_string_field, :complete, step: step)
    create(:adventure_step_form_field_response, value: '10', form_field: number_field, user: user)
    [{
      'id' => SecureRandom.uuid,
      'formFieldId' => date_field.id,
      'value' => '2020-09-20'
    }, {
      'id' => SecureRandom.uuid,
      'formFieldId' => number_field.id,
      'value' => '20'
    }, {
      'id' => SecureRandom.uuid,
      'formFieldId' => radio_field.id,
      'value' => radio_field.options.first
    }, {
      'id' => SecureRandom.uuid,
      'formFieldId' => string_field.id,
      'value' => 'the quick brown fox'
    }]
  end
  let(:data) do
    {
      'adventureStepFormFieldResponseBulkUpsert' => {
        'responses' => attributes.map do |response|
          {
            'id' => response['id'],
            'value' => response['value'],
            'formField' => {
              'id' => response['formFieldId']
            }
          }
        end,
        'step' => {
          'id' => step.id
        }
      }
    }
  end

  it 'return responses and step' do
    resolve(query, variables: { 'stepId' => step.slug, 'attributes' => attributes }, context: { current_user: user })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when no step by slug' do
    it 'returns error' do
      resolve(query, variables: { 'stepId' => SecureRandom.uuid, 'attributes' => attributes },
                     context: { current_user: user })
      expect(response_errors[0]['extensions']['code']).to eq('NOT_FOUND'), invalid_response_data
    end
  end

  context 'when response is invalid' do
    before { Adventure::Step::FormField::NumberField.find(attributes[1]['formFieldId']).update(max: 19) }

    it 'returns error' do
      resolve(query, variables: { 'stepId' => step.slug, 'attributes' => attributes },
                     context: { current_user: user })
      expect(response_errors[0]['extensions']['code']).to eq('INVALID'), invalid_response_data
    end
  end

  def query
    <<~GQL
      mutation(
        $stepId: ID!
        $attributes: [AdventureStepFormFieldResponseBulkUpsertMutationInputType!]!
      ) {
        adventureStepFormFieldResponseBulkUpsert(input: { stepId: $stepId, attributes: $attributes }) {
          responses {
            id
            value
            formField {
              id
            }
          }
          step {
            id
          }
        }
      }
    GQL
  end
end
