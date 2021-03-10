# frozen_string_literal: true

class Types::User::MeType < Types::UserType
  field :given_name, type: String, null: true
  field :family_name, type: String, null: true
  field :nickname, type: String, null: true
  field :locale, type: String, null: true
  field :email, type: String, null: true
  field :email_verified, type: Boolean, null: true
  field :admin, type: Boolean, null: false

  def admin
    object.has_role?(:admin)
  end
end
