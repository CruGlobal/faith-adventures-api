# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::AdventureQuery, type: :query do
  let!(:adventure) { create(:adventure, :complete, published: true) }
  let(:data) do
    {
      'adventure' => {
        'id' => adventure.id,
        'name' => adventure.name,
        'locale' => adventure.locale.underscore.upcase,
        'description' => adventure.description,
        'tagList' => adventure.tag_list.sort,
        'content' => {
          'id' => adventure.content.id,
          'name' => adventure.content.name,
          'description' => adventure.content.description,
          'locale' => adventure.content.locale.underscore.upcase,
          'mediaComponentId' => adventure.content.media_component_id,
          'mediaLanguageId' => adventure.content.media_language_id
        }
      }
    }
  end

  it 'return adventure' do
    resolve(query, variables: { slug: adventure.slug })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when no adventure by slug' do
    it 'returns error' do
      resolve(query, variables: { slug: 'unknown-adventure' })
      expect(response_errors[0]['extensions']['code']).to eq('NOT_FOUND'), invalid_response_data
    end
  end

  def query
    <<~GQL
      query($slug: String!) {
        adventure(slug: $slug) {
          id
          name
          locale
          description
          tagList
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
