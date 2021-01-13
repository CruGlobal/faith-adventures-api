# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Graphql', type: :request do
  let(:json_response) { JSON.parse(response.body) }
  let(:user) { create(:user) }

  before { allow(User).to receive(:from_token) { user } }

  describe 'POST graphql#execute' do
    let(:params) do
      {
        query: <<~GQL
          query {
            me {
              id
            }
          }
        GQL
      }.to_json
    end
    let(:headers) { { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer access_token' } }
    let(:data) { { 'data' => { 'me' => { 'id' => user.id } } } }

    it 'runs authenticated query' do
      post graphql_path,
           params: params,
           headers: headers
      expect(json_response).to eq data
    end
  end
end
