# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::ContentsQuery, type: :query do
  let!(:content) { create(:content_arclight, :complete) }
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

  context 'when filtered by locale' do
    let(:content) { create(:content_arclight, :complete, locale: 'en') }

    it 'return contents' do
      resolve(query, variables: { locale: 'EN' })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  def query
    <<~GQL
      query($locale: LocaleEnum) {
        contents(locale: $locale) {
          nodes {
            id
          }
        }
      }
    GQL
  end
end
