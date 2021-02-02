# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::ContentQuery, type: :query do
  let!(:content) { create(:content_arclight, :complete) }
  let(:data) do
    {
      'content' => {
        'id' => content.id,
        'name' => content.name,
        'description' => content.description,
        'locale' => content.locale.underscore.upcase,
        'mediaComponentId' => content.media_component_id,
        'mediaLanguageId' => content.media_language_id,
        'duration' => content.duration,
        'pictureSmallUrl' => content.picture_small_url,
        'pictureMediumUrl' => content.picture_medium_url,
        'pictureLargeUrl' => content.picture_large_url,
        'hlsUrl' => content.hls_url
      }
    }
  end

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
        }
      }
    GQL
  end
end
