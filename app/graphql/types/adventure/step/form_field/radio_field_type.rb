# frozen_string_literal: true

class Types::Adventure::Step::FormField::RadioFieldType < Types::BaseRecord
  implements Types::Adventure::Step::FormFieldInterface

  field :options, type: [String], null: false
end
