# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Adventure::StartMutation, type: :query do
  let(:user) { create(:user) }
  let(:adventure) { create(:adventure, :complete, published: true) }
  let!(:step) { create(:adventure_step, adventure: adventure) }
  let(:my_adventure) { Adventure.joins(:users).find_by(users: { id: user.id }, template: adventure) }
  let(:data) do
    {
      'adventureStart' => {
        'clientMutationId' => 'abc',
        'adventure' => {
          'id' => my_adventure.id,
          'name' => adventure.name,
          'locale' => adventure.locale.underscore.upcase,
          'description' => adventure.description,
          'tagList' => adventure.tag_list.sort,
          'slug' => my_adventure.slug,
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
              'id' => my_adventure.steps.first.id,
              'name' => step.name,
              'slug' => my_adventure.steps.first.slug,
              'content' => {
                'id' => step.content.id,
                'name' => step.content.name,
                'description' => step.content.description,
                'locale' => step.content.locale.underscore.upcase,
                'mediaComponentId' => step.content.media_component_id,
                'mediaLanguageId' => step.content.media_language_id
              }
            }]
          }
        }
      }
    }
  end

  it 'return adventure' do
    resolve(query, variables: { id: adventure.slug }, context: { current_user: user })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when no adventure by slug' do
    it 'returns error' do
      resolve(query, variables: { id: 'unknown-adventure' }, context: { current_user: user })
      expect(response_errors[0]['extensions']['code']).to eq('NOT_FOUND'), invalid_response_data
    end
  end

  def query
    <<~GQL
      mutation($id: ID!) {
        adventureStart(
          input: {
            id: $id,
            clientMutationId: "abc"
          }) {
          clientMutationId
          adventure {
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
          }
        }
      }
    GQL
  end
end
