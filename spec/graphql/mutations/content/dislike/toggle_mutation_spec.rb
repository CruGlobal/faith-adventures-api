# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Content::Dislike::ToggleMutation, type: :query do
  let(:user) { create(:user) }
  let(:content) { create(:content_arclight, :complete) }
  let(:data) do
    {
      'contentDislikeToggle' => {
        'clientMutationId' => 'abc',
        'dislike' => {
          'content' => {
            'id' => content.id,
            'dislikesCount' => 1,
            'dislike' => true
          },
          'user' => {
            'id' => user.id
          }
        }
      }
    }
  end

  it 'return dislike' do
    resolve(query, variables: { id: content.slug }, context: { current_user: user })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when dislike already exists' do
    before { create(:content_dislike, content: content, user: user) }

    let(:data) do
      {
        'contentDislikeToggle' => {
          'clientMutationId' => 'abc',
          'dislike' => {
            'content' => {
              'id' => content.id,
              'dislikesCount' => 0,
              'dislike' => false
            },
            'user' => {
              'id' => user.id
            }
          }
        }
      }
    end

    it 'return dislike' do
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
        contentDislikeToggle(
          input: {
            id: $id,
            clientMutationId: "abc"
          }) {
          clientMutationId
          dislike {
            content {
              id
              dislikesCount
              dislike
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
