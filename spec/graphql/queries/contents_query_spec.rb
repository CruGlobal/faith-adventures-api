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

  def query
    <<~GQL
      query {
        contents {
          nodes {
            id
          }
        }
      }
    GQL
  end
end
