# frozen_string_literal: true

module Types::Adventure::Step::FormFieldInterface
  include Types::BaseInterface
  field :id, ID, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  field :name, String, null: false
  orphan_types Types::Adventure::Step::FormField::DateFieldType,
               Types::Adventure::Step::FormField::IntegerFieldType,
               Types::Adventure::Step::FormField::TextFieldType

  definition_methods do
    def resolve_type(object, _context)
      "Types::#{object.type}Type".constantize
    end
  end
end
