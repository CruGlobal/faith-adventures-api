# frozen_string_literal: true

class Mutations::Adventure::Step::CreateMutation < Mutations::AuthenticatedMutation
  graphql_name 'AdventureStepCreateMutation'
  argument :adventure_id, ID, required: true
  argument :attributes, InputTypes::Adventure::StepInputType, required: true
  field :step, Types::Adventure::StepType, null: false

  def resolve(adventure_id:, attributes:)
    adventure = Adventure.find(adventure_id)
    raise GraphQL::ExecutionError, 'owners only' unless context[:current_user].has_role?(:owner, adventure)

    step = adventure.steps.create!(attributes.to_h)
    { step: step }
  end
end
