# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Adventure::Step::UpdateMutation, type: :query do
  let(:user) { create(:user) }
  let(:content) { create(:content_arclight, :complete) }
  let(:step) { create(:adventure_step) }
  let(:attributes) do
    {
      id: step.id,
      name: Faker::Name.name,
      contentId: content.id
    }
  end
  let(:data) do
    {
      'adventureStepUpdate' => {
        'clientMutationId' => 'abc',
        'step' => {
          'id' => attributes[:id],
          'name' => attributes[:name],
          'content' => {
            'id' => attributes[:contentId]
          }
        }
      }
    }
  end

  it 'return error' do
    resolve(query, variables: { attributes: attributes }, context: { current_user: user })
    expect(response_errors[0]['message']).to eq('owners only'), invalid_response_data
  end

  context 'when owner' do
    before { user.add_role(:owner, step.adventure) }

    it 'return step' do
      resolve(query, variables: { attributes: attributes }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  def query
    <<~GQL
      mutation($attributes: AdventureStepUpdateInput!) {
        adventureStepUpdate(
          input: {
            attributes: $attributes,
            clientMutationId: "abc"
          }) {
          clientMutationId
          step {
            id
            name
            content {
              id
            }
          }
        }
      }
    GQL
  end
end
