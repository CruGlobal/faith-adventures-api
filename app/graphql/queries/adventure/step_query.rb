# frozen_string_literal: true

class Queries::Adventure::StepQuery < Queries::AuthenticatedQuery
  description 'Find adventure step by ID or slug'
  type Types::Adventure::StepType, null: false
  argument :id, ID, required: true, description: 'Can be ID or slug'

  def resolve(id:)
    context[:current_user].steps.friendly.find(id)
  end
end
