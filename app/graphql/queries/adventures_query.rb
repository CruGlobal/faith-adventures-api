# frozen_string_literal: true

class Queries::AdventuresQuery < Queries::ApplicationQuery
  description 'List of adventures'
  type Types::AdventureType.connection_type, null: false
  argument :featured, Boolean, required: false

  def resolve(featured: nil)
    adventures = Adventure.published
    adventures = adventures.where(featured: featured ? true : [false, nil]) unless featured.nil?

    adventures
  end
end
