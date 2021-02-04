# frozen_string_literal: true

module Types::ContentInterface
  include Types::BaseInterface
  field :id, ID, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  field :name, String, null: false
  field :slug, String, null: false
  field :description, String, null: true
  field :locale, type: Types::LocaleEnum, null: false
  field :adventures, type: Types::AdventureType.connection_type, null: false
  orphan_types Types::Content::ArclightType

  def adventures
    scope = Adventure.left_outer_joins(:steps).published
    scope.where(content_id: object.id)
         .or(scope.where({ adventure_steps: { content_id: object.id } }))
         .order('adventures.created_at')
         .distinct
  end

  definition_methods do
    def resolve_type(object, _context)
      "Types::#{object.type}Type".constantize
    end
  end
end
