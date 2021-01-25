# frozen_string_literal: true

class Mutations::Adventure::StartMutation < Mutations::AuthenticatedMutation
  graphql_name 'AdventureStartMutation'
  argument :id, ID, required: true, description: 'Can be ID or slug of adventure'
  field :adventure, Types::AdventureType, null: false

  def resolve(id:)
    adventure = Adventure.published.friendly.find(id).start(context[:current_user])
    { adventure: adventure }
  end
end
