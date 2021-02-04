# frozen_string_literal: true

class Queries::ContentQuery < Queries::ApplicationQuery
  description 'Find content by ID or slug'
  type Types::ContentInterface, null: false
  argument :id, ID, required: true, description: 'Can be ID or slug'

  def resolve(id:)
    Content.published.friendly.find(id)
  end
end
