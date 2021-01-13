# frozen_string_literal: true

class Queries::MeQuery < Queries::AuthenticatedQuery
  description 'Current User'
  type Types::User::MeType, null: false

  def resolve
    context[:current_user]
  end
end
