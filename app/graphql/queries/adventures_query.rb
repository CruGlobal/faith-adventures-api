# frozen_string_literal: true

class Queries::AdventuresQuery < Queries::ApplicationQuery
  description 'List of adventures'
  type Types::AdventureType.connection_type, null: false
  argument :featured, Boolean, required: false
  argument :scope_to_user, Boolean, required: false, description: "Should scope to current user's adventures"

  def resolve(featured: nil, scope_to_user: false)
    adventures = scope(scope_to_user)
    adventures = adventures.where(featured: featured ? true : [false, nil]) unless featured.nil?

    adventures
  end

  protected

  def scope(scope_to_user)
    return Adventure.published unless scope_to_user
    return Adventure.none unless context[:current_user]

    context[:current_user].adventures
  end
end
