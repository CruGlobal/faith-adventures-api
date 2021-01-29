# frozen_string_literal: true

module Types::Adventure::Step::FormFieldInterface
  include Types::BaseInterface
  field :id, ID, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  field :name, String, null: false
  field :required, Boolean, null: false
  field :position, type: Integer, null: false
  field :step, type: Types::Adventure::StepType, null: false
  field :my_response, type: Types::Adventure::Step::FormField::ResponseType, null: true
  orphan_types Types::Adventure::Step::FormField::DateFieldType,
               Types::Adventure::Step::FormField::NumberFieldType,
               Types::Adventure::Step::FormField::RadioFieldType,
               Types::Adventure::Step::FormField::StringFieldType

  definition_methods do
    def resolve_type(object, _context)
      "Types::#{object.type}Type".constantize
    end
  end

  def my_response
    object.responses.find_by(user: context[:current_user])
  end
end
