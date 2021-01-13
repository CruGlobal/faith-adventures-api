# frozen_string_literal: true

class User::JsonWebTokenService
  CACHE_KEY = 'User::JsonWebTokenService.jwks'
  attr_accessor :token

  def self.verify(token)
    new(token).verify
  end

  def initialize(token)
    @token = token
  end

  def verify
    JWT.decode(
      token, nil, true,
      algorithms: 'RS256',
      iss: "https://#{ENV.fetch('AUTH0_DOMAIN')}/",
      verify_iss: true,
      aud: ENV.fetch('AUTH0_AUDIENCE'),
      verify_aud: true,
      jwks: jwk_loader
    ).first
  end

  private

  def jwk_loader
    lambda do |options|
      Rails.cache.delete(CACHE_KEY) if options[:invalidate]
      Rails.cache.fetch(CACHE_KEY, expires_in: 1.day) do
        { keys: jwks_from_api }
      end
    end
  end

  def jwks_from_api
    HTTParty.get("https://#{ENV.fetch('AUTH0_DOMAIN')}/.well-known/jwks.json")['keys'].map do |k|
      k.transform_keys(&:to_sym)
    end
  end
end
