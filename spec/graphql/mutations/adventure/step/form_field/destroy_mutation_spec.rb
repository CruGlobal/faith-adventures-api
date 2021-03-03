# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Adventure::Step::FormField::DestroyMutation, type: :query do
  let(:user) { create(:user) }
  let(:content) { create(:content_arclight, :complete) }
  let(:form_field) { create(:adventure_step_form_field_string_field) }
  let(:data) do
    {
      'adventureStepFormFieldDestroy' => {
        'clientMutationId' => 'abc',
        'id' => form_field.id
      }
    }
  end

  it 'return error' do
    resolve(query, variables: { id: form_field.id }, context: { current_user: user })
    expect(response_errors[0]['message']).to eq('owners only'), invalid_response_data
  end

  context 'when owner' do
    before { user.add_role(:owner, form_field.step.adventure) }

    it 'return step_id' do
      resolve(query, variables: { id: form_field.id }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  def query
    <<~GQL
      mutation($id: ID!) {
        adventureStepFormFieldDestroy(
          input: {
            id: $id,
            clientMutationId: "abc"
          }) {
          clientMutationId
          id
        }
      }
    GQL
  end
end
