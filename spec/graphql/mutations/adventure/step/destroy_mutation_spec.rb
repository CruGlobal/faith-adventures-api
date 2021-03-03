# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Adventure::Step::DestroyMutation, type: :query do
  let(:user) { create(:user) }
  let(:content) { create(:content_arclight, :complete) }
  let(:adventure) { create(:adventure) }
  let(:step) { create(:adventure_step, adventure: adventure) }
  let(:data) do
    {
      'adventureStepDestroy' => {
        'clientMutationId' => 'abc',
        'id' => step.id
      }
    }
  end

  it 'return error' do
    resolve(query, variables: { id: step.id }, context: { current_user: user })
    expect(response_errors[0]['message']).to eq('owners only'), invalid_response_data
  end

  context 'when owner' do
    before { user.add_role(:owner, adventure) }

    it 'return step_id' do
      resolve(query, variables: { id: step.id }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  def query
    <<~GQL
      mutation($id: ID!) {
        adventureStepDestroy(
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
