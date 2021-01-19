# frozen_string_literal: true

class User < ApplicationRecord
  validates :sub, presence: true, uniqueness: true

  def self.from_token(token)
    verified_token = FirebaseIdToken::Signature.verify(token)
    return unless verified_token

    user = find_or_initialize_by(sub: verified_token['sub'])
    user.attributes = verified_token.slice('name', 'picture', 'email', 'email_verified')
    user.save

    user
  end
end
