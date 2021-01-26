# frozen_string_literal: true

class Queries::AdventureQuery < Queries::ApplicationQuery
  description 'Find adventure by ID or slug'
  type Types::AdventureType, null: false
  argument :id, ID, required: true, description: 'Can be ID or slug'

  def resolve(id:)
    adventure_scope.friendly.find(id)
  end

  protected

  def adventure_scope
    adventure_scope = Adventure.published.left_outer_joins(:memberships)
    return adventure_scope unless context[:current_user]

    adventure_scope
      .left_outer_joins(:memberships)
      .or(
        Adventure
          .left_outer_joins(:memberships)
          .where(adventure_memberships: { user_id: context[:current_user].id })
      )
  end
end
