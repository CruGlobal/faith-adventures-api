# frozen_string_literal: true

class Queries::AdventureQuery < Queries::ApplicationQuery
  description 'Find adventure by ID or slug'
  type Types::AdventureType, null: false
  argument :id, ID, required: true, description: 'Can be ID or slug'

  def resolve(id:)
    Adventure.friendly.find(id)
  end
end
