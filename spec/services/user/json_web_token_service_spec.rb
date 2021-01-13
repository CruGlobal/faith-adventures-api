# frozen_string_literal: true

require 'rails_helper'

describe User::JsonWebTokenService do
  subject(:json_web_token_service) { described_class.new(token) }

  let(:jwk) { JWT::JWK.new(OpenSSL::PKey::RSA.new(2048)) }
  let(:payload) do
    {
      'aud' => 'http://example.com/graphql',
      'data' => 'data',
      'iss' => 'https://example.com/'
    }
  end
  let(:token) do
    JWT.encode(
      payload,
      jwk.keypair,
      'RS256',
      { kid: jwk.kid }
    )
  end

  before do
    stub_request(:get, 'https://example.com/.well-known/jwks.json')
      .and_return(headers: { 'Content-Type' => 'application/json' }, body: { 'keys' => [jwk.export] }.to_json)
  end

  describe '.verify' do
    it 'verifies token' do
      expect(described_class.verify(token)).to eq(payload)
    end
  end

  describe '#verify' do
    it 'verifies token' do
      expect(json_web_token_service.verify).to eq(payload)
    end
  end
end
