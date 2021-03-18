# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Content::Like::ToggleMutation, type: :query do
  let(:user) { create(:user) }
  let(:content) { create(:content_arclight, :complete) }
  let(:data) do
    {
      'contentLikeToggle' => {
        'clientMutationId' => 'abc',
        'like' => {
          'content' => {
            'id' => content.id,
            'likesCount' => 1,
            'like' => true
          },
          'user' => {
            'id' => user.id
          }
        }
      }
    }
  end

  it 'return like' do
    resolve(query, variables: { id: content.slug }, context: { current_user: user })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when like already exists' do
    before { create(:content_like, content: content, user: user) }

    let(:data) do
      {
        'contentLikeToggle' => {
          'clientMutationId' => 'abc',
          'like' => {
            'content' => {
              'id' => content.id,
              'likesCount' => 0,
              'like' => false
            },
            'user' => {
              'id' => user.id
            }
          }
        }
      }
    end

    it 'return like' do
      resolve(query, variables: { id: content.slug }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  context 'when no content by slug' do
    it 'returns error' do
      resolve(query, variables: { id: 'unknown-content' }, context: { current_user: user })
      expect(response_errors[0]['extensions']['code']).to eq('NOT_FOUND'), invalid_response_data
    end
  end

  def query
    <<~GQL
      mutation($id: ID!) {
        contentLikeToggle(
          input: {
            id: $id,
            clientMutationId: "abc"
          }) {
          clientMutationId
          like {
            content {
              id
              likesCount
              like
            }
            user {
              id
            }
          }
        }
      }
    GQL
  end
end
