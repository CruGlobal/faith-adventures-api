# frozen_string_literal: true

class Types::Adventure::Step::FormField::StringFieldType < Types::BaseRecord
  implements Types::Adventure::Step::FormFieldInterface

  field :min_length, type: Integer, null: true
  field :max_length, type: Integer, null: true
end
