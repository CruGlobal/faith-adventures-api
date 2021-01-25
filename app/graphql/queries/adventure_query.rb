# frozen_string_literal: true

class Queries::AdventureQuery < Queries::ApplicationQuery
  description 'Find adventure by ID or slug'
  type Types::AdventureType, null: false
  argument :id, ID, required: true, description: 'Can be ID or slug'
  argument :scope_to_user, Boolean, required: false, description: "Should scope to current user's adventures"

  def resolve(id:, scope_to_user: false)
    scope(scope_to_user).friendly.find(id)
  end

  protected

  def scope(scope_to_user)
    return Adventure.published unless scope_to_user
    return Adventure.none unless context[:current_user]

    context[:current_user].adventures
  end
end
