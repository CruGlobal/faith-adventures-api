# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::ContentQuery, type: :query do
  let!(:content) { create(:content_arclight, :complete) }
  let!(:adventure1) { create(:adventure, :complete, content: content, published: true, created_at: 1.month.ago) }
  let!(:adventure2) { create(:adventure, :complete, published: true) }
  let(:data) do
    {
      'content' => {
        'id' => content.id,
        'name' => content.name,
        'slug' => content.slug,
        'description' => content.description,
        'locale' => content.locale.underscore.upcase,
        'mediaComponentId' => content.media_component_id,
        'mediaLanguageId' => content.media_language_id,
        'duration' => content.duration,
        'pictureSmallUrl' => content.picture_small_url,
        'pictureMediumUrl' => content.picture_medium_url,
        'pictureLargeUrl' => content.picture_large_url,
        'hlsUrl' => content.hls_url,
        'adventures' => {
          'nodes' => [{ 'id' => adventure1.id }, { 'id' => adventure2.id }]
        }
      }
    }
  end

  before { create(:adventure_step, content: content, adventure: adventure2) }

  it 'return content' do
    resolve(query, variables: { id: content.slug })
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when no content by slug' do
    it 'returns error' do
      resolve(query, variables: { id: 'unknown-content' })
      expect(response_errors[0]['extensions']['code']).to eq('NOT_FOUND'), invalid_response_data
    end
  end

  def query
    <<~GQL
      query($id: ID!) {
        content(id: $id) {
          id
          name
          slug
          description
          locale
          ... on Arclight {
            mediaComponentId
            mediaLanguageId
            duration
            pictureSmallUrl
            pictureMediumUrl
            pictureLargeUrl
            hlsUrl
          }
          adventures {
            nodes {
              id
            }
          }
        }
      }
    GQL
  end
end
