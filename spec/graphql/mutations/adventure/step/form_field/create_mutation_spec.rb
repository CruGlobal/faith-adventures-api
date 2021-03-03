# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Adventure::Step::FormField::CreateMutation, type: :query do
  let(:user) { create(:user) }
  let(:step) { create(:adventure_step) }
  let(:attributes) do
    {
      id: SecureRandom.uuid,
      name: Faker::Name.name,
      required: true,
      type: 'STRING',
      stringField: {
        minLength: 0,
        maxLength: 10
      }
    }
  end
  let(:data) do
    {
      'adventureStepFormFieldCreate' => {
        'clientMutationId' => 'abc',
        'formField' => {
          'id' => attributes[:id],
          'name' => attributes[:name],
          'required' => attributes[:required],
          'type' => attributes[:type],
          'minLength' => attributes[:stringField][:minLength],
          'maxLength' => attributes[:stringField][:maxLength]
        }
      }
    }
  end

  before { user.add_role(:owner, step.adventure) }

  it 'return form_field' do
    resolve(query, variables: { step_id: step.id, attributes: attributes }, context: { current_user: user })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when not owner' do
    before { user.remove_role(:owner, step.adventure) }

    it 'return error' do
      resolve(query, variables: { step_id: step.id, attributes: attributes }, context: { current_user: user })
      expect(response_errors[0]['message']).to eq('owners only'), invalid_response_data
    end
  end

  context 'when date' do
    let(:attributes) do
      {
        id: SecureRandom.uuid,
        name: Faker::Name.name,
        required: true,
        type: 'DATE',
        dateField: {
          maxDate: Date.today.iso8601,
          minDate: (Date.today - 2.days).iso8601
        }
      }
    end
    let(:data) do
      {
        'adventureStepFormFieldCreate' => {
          'clientMutationId' => 'abc',
          'formField' => {
            'id' => attributes[:id],
            'name' => attributes[:name],
            'required' => attributes[:required],
            'type' => attributes[:type],
            'maxDate' => attributes[:dateField][:maxDate],
            'minDate' => attributes[:dateField][:minDate]
          }
        }
      }
    end

    it 'return form_field' do
      resolve(query, variables: { step_id: step.id, attributes: attributes }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  context 'when number' do
    let(:attributes) do
      {
        id: SecureRandom.uuid,
        name: Faker::Name.name,
        required: true,
        type: 'NUMBER',
        numberField: {
          max: 10,
          min: 0
        }
      }
    end
    let(:data) do
      {
        'adventureStepFormFieldCreate' => {
          'clientMutationId' => 'abc',
          'formField' => {
            'id' => attributes[:id],
            'name' => attributes[:name],
            'required' => attributes[:required],
            'type' => attributes[:type],
            'max' => attributes[:numberField][:max],
            'min' => attributes[:numberField][:min]
          }
        }
      }
    end

    it 'return form_field' do
      resolve(query, variables: { step_id: step.id, attributes: attributes }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  context 'when radio' do
    let(:attributes) do
      {
        id: SecureRandom.uuid,
        name: Faker::Name.name,
        required: true,
        type: 'RADIO',
        radioField: {
          options: %w[abc def]
        }
      }
    end
    let(:data) do
      {
        'adventureStepFormFieldCreate' => {
          'clientMutationId' => 'abc',
          'formField' => {
            'id' => attributes[:id],
            'name' => attributes[:name],
            'required' => attributes[:required],
            'type' => attributes[:type],
            'options' => attributes[:radioField][:options]
          }
        }
      }
    end

    it 'return form_field' do
      resolve(query, variables: { step_id: step.id, attributes: attributes }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  def query
    <<~GQL
      mutation($step_id: ID!, $attributes: AdventureStepFormFieldInput!) {
        adventureStepFormFieldCreate(
          input: {
            attributes: $attributes,
            stepId: $step_id,
            clientMutationId: "abc"
          }) {
          clientMutationId
          formField {
            id
            name
            required
            type
            ... on DateField {
              maxDate
              minDate
            }
            ... on NumberField {
              max
              min
            }
            ... on RadioField {
              options
            }
            ... on StringField {
              maxLength
              minLength
            }
          }
        }
      }
    GQL
  end
end
