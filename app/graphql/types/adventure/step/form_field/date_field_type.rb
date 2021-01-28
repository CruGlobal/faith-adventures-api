# frozen_string_literal: true

class Types::Adventure::Step::FormField::DateFieldType < Types::BaseRecord
  implements Types::Adventure::Step::FormFieldInterface

  field :min_date, type: GraphQL::Types::ISO8601Date, null: true
  field :max_date, type: GraphQL::Types::ISO8601Date, null: true
end
