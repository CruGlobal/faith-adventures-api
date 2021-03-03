# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Adventure::UpdateMutation, type: :query do
  let(:user) { create(:user) }
  let(:content) { create(:content_arclight, :complete) }
  let(:adventure) { create(:adventure) }
  let(:attributes) do
    {
      id: adventure.id,
      name: Faker::Name.name,
      description: Faker::Company.catch_phrase,
      contentId: content.id,
      locale: I18n.available_locales.sample.to_s.underscore.upcase
    }
  end
  let(:data) do
    {
      'adventureUpdate' => {
        'clientMutationId' => 'abc',
        'adventure' => {
          'id' => attributes[:id],
          'name' => attributes[:name],
          'description' => attributes[:description],
          'locale' => attributes[:locale],
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
    before { user.add_role(:owner, adventure) }

    it 'return adventure' do
      resolve(query, variables: { attributes: attributes }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  def query
    <<~GQL
      mutation($attributes: AdventureInput!) {
        adventureUpdate(
          input: {
            attributes: $attributes,
            clientMutationId: "abc"
          }) {
          clientMutationId
          adventure {
            id
            name
            description
            locale
            content {
              id
            }
          }
        }
      }
    GQL
  end
end
