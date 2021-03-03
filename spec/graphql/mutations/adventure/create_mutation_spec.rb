# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Adventure::CreateMutation, type: :query do
  let(:user) { create(:user) }
  let(:content) { create(:content_arclight, :complete) }
  let(:attributes) do
    {
      id: SecureRandom.uuid,
      name: Faker::Name.name,
      description: Faker::Company.catch_phrase,
      contentId: content.id,
      locale: I18n.available_locales.sample.to_s.underscore.upcase
    }
  end
  let(:data) do
    {
      'adventureCreate' => {
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

  it 'return adventure' do
    resolve(query, variables: { attributes: attributes }, context: { current_user: user })
    expect(response_data).to eq(data), invalid_response_data
  end

  it 'adds owner role' do
    resolve(query, variables: { attributes: attributes }, context: { current_user: user })
    expect(user.has_role?(:owner, Adventure.find(attributes[:id]))).to eq true
  end

  def query
    <<~GQL
      mutation($attributes: AdventureInput!) {
        adventureCreate(
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
