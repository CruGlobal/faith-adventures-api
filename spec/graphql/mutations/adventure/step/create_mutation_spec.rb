# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Adventure::Step::CreateMutation, type: :query do
  let(:user) { create(:user) }
  let(:content) { create(:content_arclight, :complete) }
  let(:adventure) { create(:adventure) }
  let(:attributes) do
    {
      id: SecureRandom.uuid,
      name: Faker::Name.name,
      contentId: content.id
    }
  end
  let(:data) do
    {
      'adventureStepCreate' => {
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
    resolve(query, variables: { adventure_id: adventure.id, attributes: attributes }, context: { current_user: user })
    expect(response_errors[0]['message']).to eq('owners only'), invalid_response_data
  end

  context 'when owner' do
    before { user.add_role(:owner, adventure) }

    it 'return step' do
      resolve(query, variables: { adventure_id: adventure.id, attributes: attributes }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  def query
    <<~GQL
      mutation($adventure_id: ID!, $attributes: AdventureStepInput!) {
        adventureStepCreate(
          input: {
            attributes: $attributes,
            adventureId: $adventure_id,
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
