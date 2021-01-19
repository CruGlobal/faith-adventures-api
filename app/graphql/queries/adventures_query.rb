# frozen_string_literal: true

class Queries::AdventuresQuery < Queries::ApplicationQuery
  description 'List of adventures'
  type Types::AdventureType.connection_type, null: false

  def resolve
    Adventure.published
  end
end
