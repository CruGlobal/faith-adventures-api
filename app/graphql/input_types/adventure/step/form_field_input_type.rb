# frozen_string_literal: true

class InputTypes::Adventure::Step::FormFieldInputType < Types::BaseInputObject
  graphql_name 'AdventureStepFormFieldInput'
  description 'Attributes for creating a formField'
  argument :id, ID, required: true
  argument :name, String, required: true
  argument :required, Boolean, required: true
  argument :type, Types::Adventure::Step::FormField::TypeEnum, required: true
  argument :date_field, InputTypes::Adventure::Step::FormField::DateFieldInputType, required: false
  argument :number_field, InputTypes::Adventure::Step::FormField::NumberFieldInputType, required: false
  argument :radio_field, InputTypes::Adventure::Step::FormField::RadioFieldInputType, required: false
  argument :string_field, InputTypes::Adventure::Step::FormField::StringFieldInputType, required: false
end
