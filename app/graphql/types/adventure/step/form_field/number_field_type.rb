# frozen_string_literal: true

class Types::Adventure::Step::FormField::NumberFieldType < Types::BaseRecord
  implements Types::Adventure::Step::FormFieldInterface

  field :min, type: Integer, null: true
  field :max, type: Integer, null: true
end
