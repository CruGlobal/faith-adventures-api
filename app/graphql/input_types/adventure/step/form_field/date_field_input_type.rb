# frozen_string_literal: true

class InputTypes::Adventure::Step::FormField::DateFieldInputType < Types::BaseInputObject
  argument :max_date, GraphQL::Types::ISO8601Date, required: false
  argument :min_date, GraphQL::Types::ISO8601Date, required: false
end
