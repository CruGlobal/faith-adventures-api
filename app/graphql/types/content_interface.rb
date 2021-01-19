# frozen_string_literal: true

module Types::ContentInterface
  include Types::BaseInterface
  field :id, ID, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  field :name, String, null: false
  field :description, String, null: true
  field :locale, type: Types::LocaleEnum, null: false
  orphan_types Types::Content::ArclightType

  definition_methods do
    def resolve_type(object, _context)
      "Types::#{object.type}Type".constantize
    end
  end
end
