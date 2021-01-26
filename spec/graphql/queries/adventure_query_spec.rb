# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::AdventureQuery, type: :query do
  let!(:adventure) { create(:adventure, :complete, published: true) }
  let!(:step) { create(:adventure_step, adventure: adventure) }
  let(:data) do
    {
      'adventure' => {
        'id' => adventure.id,
        'name' => adventure.name,
        'locale' => adventure.locale.underscore.upcase,
        'description' => adventure.description,
        'tagList' => adventure.tag_list.sort,
        'slug' => adventure.slug,
        'content' => {
          'id' => adventure.content.id,
          'name' => adventure.content.name,
          'description' => adventure.content.description,
          'locale' => adventure.content.locale.underscore.upcase,
          'mediaComponentId' => adventure.content.media_component_id,
          'mediaLanguageId' => adventure.content.media_language_id
        },
        'steps' => {
          'totalCount' => adventure.steps.count,
          'nodes' => [{
            'id' => step.id,
            'name' => step.name,
            'slug' => step.slug,
            'content' => {
              'id' => step.content.id,
              'name' => step.content.name,
              'description' => step.content.description,
              'locale' => step.content.locale.underscore.upcase,
              'mediaComponentId' => step.content.media_component_id,
              'mediaLanguageId' => step.content.media_language_id
            }
          }]
        },
        'children' => {
          'nodes' => []
        }
      }
    }
  end

  it 'return adventure' do
    resolve(query, variables: { id: adventure.slug })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when no adventure by slug' do
    it 'returns error' do
      resolve(query, variables: { id: 'unknown-adventure' })
      expect(response_errors[0]['extensions']['code']).to eq('NOT_FOUND'), invalid_response_data
    end
  end

  context 'when adventure not published' do
    let!(:adventure) { create(:adventure, :complete, published: false) }

    it 'returns error' do
      resolve(query, variables: { id: adventure.slug })
      expect(response_errors[0]['extensions']['code']).to eq('NOT_FOUND'), invalid_response_data
    end
  end

  context 'when adventure is clone' do
    let(:user) { create(:user) }
    let!(:adventure) { create(:adventure, :complete, published: true).start(user) }

    it 'returns error when no user' do
      resolve(query, variables: { id: adventure.slug })
      expect(response_errors[0]['extensions']['code']).to eq('NOT_FOUND'), invalid_response_data
    end

    it 'returns adventure when user' do
      resolve(query, variables: { id: adventure.slug }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  context 'when solo adventure exists' do
    let(:user) { create(:user) }
    let!(:clone) { adventure.start(user) }

    it 'returns solo_adventure id' do
      resolve(query, variables: { id: adventure.slug }, context: { current_user: user })
      expect(response_data['adventure']['children']['nodes'][0]['id']).to eq(clone.id), invalid_response_data
    end
  end

  def query
    <<~GQL
      query($id: ID!) {
        adventure(id: $id) {
          id
          name
          locale
          description
          tagList
          slug
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
          steps {
            totalCount
            nodes {
              id
              name
              slug
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
          children {
            nodes {
              id
            }
          }
        }
      }
    GQL
  end
end
