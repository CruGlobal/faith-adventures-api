# frozen_string_literal: true

class Mutations::Adventure::Step::UpdateMutation < Mutations::AuthenticatedMutation
  class StepUpdateInputType < InputTypes::Adventure::StepInputType
    graphql_name 'AdventureStepUpdateInput'
    argument :id, ID, required: true
  end

  graphql_name 'AdventureStepUpdateMutation'
  argument :attributes, StepUpdateInputType, required: true
  field :step, Types::Adventure::StepType, null: false

  def resolve(attributes:)
    step = Adventure::Step.find(attributes.id)
    raise GraphQL::ExecutionError, 'owners only' unless context[:current_user].has_role?(:owner, step.adventure)

    step.update!(attributes.to_h)
    { step: step }
  end
end
