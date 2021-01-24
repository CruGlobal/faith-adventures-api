# frozen_string_literal: true

class Queries::AdventureQuery < Queries::ApplicationQuery
  description 'Find adventure by slug'
  type Types::AdventureType, null: false
  argument :slug, String, required: true

  def resolve(slug:)
    Adventure.friendly.find(slug)
  end
end
