# frozen_string_literal: true

class Mutations::Adventure::UpdateMutation < Mutations::AuthenticatedMutation
  class AdventureUpdateInputType < InputTypes::AdventureInputType
    argument :id, ID, required: true
  end

  graphql_name 'AdventureUpdateMutation'
  argument :attributes, AdventureUpdateInputType, required: true
  field :adventure, Types::AdventureType, null: false

  def resolve(attributes:)
    adventure = Adventure.find(attributes.id)
    raise GraphQL::ExecutionError, 'owners only' unless context[:current_user].has_role?(:owner, adventure)

    adventure.update!(attributes.to_h)
    { adventure: adventure }
  end
end
