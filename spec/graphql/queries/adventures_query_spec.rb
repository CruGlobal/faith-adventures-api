# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::AdventuresQuery, type: :query do
  let!(:adventure) { create(:adventure, :complete, published: true) }
  let(:data) do
    {
      'adventures' => {
        'nodes' => [{
          'id' => adventure.id
        }]
      }
    }
  end

  it 'return adventure' do
    resolve(query)
    expect(response_data).to eq(data), invalid_response_data
  end

  context 'when adventure featured is nil' do
    it 'returns adventure' do
      resolve(query, variables: { featured: false })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  context 'when adventure unfeatured' do
    before { adventure.update(featured: false) }

    it 'returns adventure' do
      resolve(query, variables: { featured: false })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  context 'when adventure is featured' do
    before { adventure.update(featured: true) }

    it 'returns adventure' do
      resolve(query, variables: { featured: true })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  context 'when adventure is clone' do
    let(:user) { create(:user) }
    let!(:adventure) { create(:adventure, :complete, published: true).start(user) }

    it 'returns adventure' do
      resolve(query, variables: { scope_to_user: true }, context: { current_user: user })
      expect(response_data).to eq(data), invalid_response_data
    end
  end

  def query
    <<~GQL
      query($featured: Boolean, $scope_to_user: Boolean) {
        adventures(featured: $featured, scopeToUser: $scope_to_user) {
          nodes {
            id
          }
        }
      }
    GQL
  end
end
