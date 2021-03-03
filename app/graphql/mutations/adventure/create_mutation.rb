# frozen_string_literal: true

class Mutations::Adventure::CreateMutation < Mutations::AuthenticatedMutation
  graphql_name 'AdventureCreateMutation'
  argument :attributes, InputTypes::AdventureInputType, required: true
  field :adventure, Types::AdventureType, null: false

  def resolve(attributes:)
    adventure = Adventure.create!(attributes.to_h)
    context[:current_user].add_role(:owner, adventure)
    { adventure: adventure }
  end
end
