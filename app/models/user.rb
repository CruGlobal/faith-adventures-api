# frozen_string_literal: true

class User < ApplicationRecord
  validates :sub, presence: true, uniqueness: true

  def self.from_token(token)
    verified_token = User::JsonWebTokenService.verify(token)
    user = find_by(sub: verified_token['sub'])
    return user if user

    create(
      HTTParty.get(
        "https://#{ENV.fetch('AUTH0_DOMAIN')}/userinfo",
        headers: { 'Authorization': "Bearer #{token}" }
      ).slice('sub', 'given_name', 'family_name', 'nickname', 'name', 'picture', 'locale', 'email', 'email_verified')
    )
  end
end
