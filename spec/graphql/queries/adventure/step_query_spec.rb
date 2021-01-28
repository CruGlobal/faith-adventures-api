# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::Adventure::StepQuery, type: :query do
  let(:user) { create(:user) }
  let!(:adventure) { create(:adventure, :complete, published: true).start(user) }
  let!(:step) { create(:adventure_step, adventure: adventure) }
  let(:state) { 'ACTIVE' }
  let(:data) do
    date_field = step.form_fields.find_by(type: Adventure::Step::FormField::DateField.to_s)
    number_field = step.form_fields.find_by(type: Adventure::Step::FormField::NumberField.to_s)
    string_field = step.form_fields.find_by(type: Adventure::Step::FormField::StringField.to_s)
    response = number_field.responses.find_by(user: user)
    {
      'adventureStep' => {
        'id' => step.id,
        'name' => step.name,
        'slug' => step.slug,
        'state' => state,
        'position' => step.position,
        'adventure' => {
          'id' => adventure.id
        },
        'formFields' => {
          'nodes' => [{
            'id' => date_field.id,
            'name' => date_field.name,
            'required' => date_field.required,
            'minDate' => date_field.min_date,
            'maxDate' => date_field.max_date,
            'myResponse' => nil
          }, {
            'id' => number_field.id,
            'name' => number_field.name,
            'required' => number_field.required,
            'min' => number_field.min.to_i,
            'max' => number_field.max.to_i,
            'myResponse' => {
              'id' => response.id,
              'value' => response.value,
              'user' => {
                'id' => user.id
              }
            }
          }, {
            'id' => string_field.id,
            'name' => string_field.name,
            'required' => string_field.required,
            'minLength' => string_field.min_length.to_i,
            'maxLength' => string_field.max_length.to_i,
            'myResponse' => nil
          }]
        },
        'content' => {
          'id' => step.content.id,
          'name' => step.content.name,
          'description' => step.content.description,
          'locale' => step.content.locale.underscore.upcase,
          'mediaComponentId' => step.content.media_component_id,
          'mediaLanguageId' => step.content.media_language_id
        }
      }
    }
  end

  before do
    create(:adventure_step_form_field_date_field, :complete, step: step)
    number_field = create(:adventure_step_form_field_number_field, :complete, step: step)
    string_field = create(:adventure_step_form_field_string_field, :complete, step: step)
    create(:adventure_step_form_field_response, user: user, value: '15', form_field: number_field)
    create(:adventure_step_form_field_response, value: 'the quick brown fox', form_field: string_field)
  end

  it 'return step' do
    resolve(query, variables: { id: step.slug }, context: { current_user: user })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when no step by slug' do
    it 'returns error' do
      resolve(query, variables: { id: 'unknown-step' }, context: { current_user: user })
      expect(response_errors[0]['extensions']['code']).to eq('NOT_FOUND'), invalid_response_data
    end
  end

  context 'when step is not first' do
    let(:state) { 'LOCKED' }

    before do
      create(:adventure_step, adventure: adventure, position: 1)
      step.reload
    end

    it 'return step' do
      resolve(query, variables: { id: step.slug }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end

    context 'when first step has submissions ' do
      let(:state) { 'ACTIVE' }

      before do
        first_step = adventure.steps.where.not(id: step.id).first
        number_field = create(:adventure_step_form_field_number_field, :complete, step: first_step)
        create(:adventure_step_form_field_response, user: user, value: '15', form_field: number_field)
        step.reload
      end

      it 'return step' do
        resolve(query, variables: { id: step.slug }, context: { current_user: user })
        expect(response_data).to eq(data), invalid_response_data
      end
    end
  end

  def query
    <<~GQL
      query($id: ID!) {
        adventureStep(id: $id) {
          id
          name
          slug
          state
          position
          adventure {
            id
          }
          formFields {
            nodes {
              id
              name
              required
              myResponse {
                id
                value
                user {
                  id
                }
              }
              ... on DateField {
                minDate
                maxDate
              }
              ... on NumberField {
                min
                max
              }
              ... on StringField {
                minLength
                maxLength
              }
            }
          }
          content {
            id
            name
            description
            locale
            ... on Arclight {
              mediaComponentId
              mediaLanguageId
            }
          }
        }
      }
    GQL
  end
end
