# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::ContentsQuery, type: :query do
  let!(:content) { create(:content_arclight, :complete, published: true) }
  let(:data) do
    {
      'contents' => {
        'nodes' => [{
          'id' => content.id
        }]
      }
    }
  end

  it 'return contents' do
    resolve(query)
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when filtered by featured' do
    before { content.update(featured: true) }

    it 'returns contents' do
      resolve(query, variables: { featured: true })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  context 'when filtered by locale' do
    let(:content) { create(:content_arclight, :complete, locale: 'en', published: true) }

    it 'return contents' do
      resolve(query, variables: { locale: 'EN' })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  context 'when filtered by search' do
    it 'return contents' do
      resolve(query, variables: { search: 'eSu' })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  def query
    <<~GQL
      query($featured: Boolean, $locale: LocaleEnum, $search: String) {
        contents(featured: $featured, locale: $locale, search: $search) {
          nodes {
            id
          }
        }
      }
    GQL
  end
end
