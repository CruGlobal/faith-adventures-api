# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::AdventureQuery, type: :query do
  let!(:adventure) { create(:adventure, :complete, published: true) }
  let!(:step1) { create(:adventure_step, adventure: adventure) }
  let!(:step2) { create(:adventure_step, adventure: adventure, created_at: 2.weeks.ago) }
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
            'id' => step1.id
          }, {
            'id' => step2.id
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

    it 'returns solo_adventure id' do
      clone = adventure.start(user)
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
