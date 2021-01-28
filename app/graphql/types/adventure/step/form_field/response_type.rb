# frozen_string_literal: true

class Types::Adventure::Step::FormField::ResponseType < Types::BaseRecord
  implements Types::Adventure::Step::FormFieldInterface

  field :user, type: Types::UserType, null: false
  field :form_field, type: Types::Adventure::Step::FormFieldInterface, null: false
  field :value, type: String, null: true
end
