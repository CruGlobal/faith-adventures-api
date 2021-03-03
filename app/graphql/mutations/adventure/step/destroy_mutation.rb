# frozen_string_literal: true

class Mutations::Adventure::Step::DestroyMutation < Mutations::AuthenticatedMutation
  graphql_name 'AdventureStepDestroyMutation'
  argument :id, ID, required: true
  field :id, ID, null: false

  def resolve(id:)
    step = Adventure::Step.find(id)
    raise GraphQL::ExecutionError, 'owners only' unless context[:current_user].has_role?(:owner, step.adventure)

    step.destroy!
    { id: id }
  end
end
