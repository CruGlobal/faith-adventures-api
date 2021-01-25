# frozen_string_literal: true

class User < ApplicationRecord
  validates :sub, presence: true, uniqueness: true
  has_many :memberships, class_name: 'Adventure::Membership', dependent: :delete_all
  has_many :adventures, through: :memberships

  def self.from_token(token)
    verified_token = FirebaseIdToken::Signature.verify(token)
    return unless verified_token

    user = find_or_initialize_by(sub: verified_token['sub'])
    user.attributes = verified_token.slice('name', 'picture', 'email', 'email_verified')
    user.save

    user
  rescue FirebaseIdToken::Exceptions::NoCertificatesError
    FirebaseIdToken::Certificates.request
    retry
  end
end
