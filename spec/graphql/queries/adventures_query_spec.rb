# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::AdventuresQuery, type: :query do
  let!(:adventure) { create(:adventure, :complete, published: true) }
  let(:data) do
    {
      'adventures' => {
        'nodes' => [{
          'id' => adventure.id,
          'name' => adventure.name,
          'locale' => adventure.locale.underscore.upcase,
          'description' => adventure.description,
          'content' => {
            'id' => adventure.content.id,
            'name' => adventure.content.name,
            'description' => adventure.content.description,
            'locale' => adventure.content.locale.underscore.upcase,
            'mediaComponentId' => adventure.content.media_component_id,
            'mediaLanguageId' => adventure.content.media_language_id
          }
        }]
      }
    }
  end

  it 'return user' do
    resolve(query)
    expect(response_data).to eq(data), invalid_response_data
  end

  def query
    <<~GQL
      query {
        adventures {
          nodes {
            id
            name
            locale
            description
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
      }
    GQL
  end
end
