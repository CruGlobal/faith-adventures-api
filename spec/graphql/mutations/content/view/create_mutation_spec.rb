# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Content::View::CreateMutation, type: :query do
  let(:user) { create(:user) }
  let(:content) { create(:content_arclight, :complete) }
  let(:data) do
    {
      'contentViewCreate' => {
        'clientMutationId' => 'abc',
        'view' => {
          'content' => {
            'id' => content.id,
            'viewsCount' => 1
          },
          'user' => {
            'id' => user.id
          }
        }
      }
    }
  end

  it 'return view' do
    resolve(query, variables: { id: content.slug }, context: { current_user: user })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when view already exists' do
    before { create(:content_view, content: content, user: user) }

    it 'does not create new view' do
      expect do
        resolve(query, variables: { id: content.slug }, context: { current_user: user })
      end.not_to change(Content::View, :count)
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
        contentViewCreate(
          input: {
            id: $id,
            clientMutationId: "abc"
          }) {
          clientMutationId
          view {
            content {
              id
              viewsCount
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
