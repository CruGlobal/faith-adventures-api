# frozen_string_literal: true

class Mutations::Adventure::DestroyMutation < Mutations::AuthenticatedMutation
  graphql_name 'AdventureDestroyMutation'
  argument :id, ID, required: true
  field :id, ID, null: false

  def resolve(id:)
    adventure = Adventure.find(id)
    raise GraphQL::ExecutionError, 'owners only' unless context[:current_user].has_role?(:owner, adventure)

    adventure.destroy!
    { id: id }
  end
end
