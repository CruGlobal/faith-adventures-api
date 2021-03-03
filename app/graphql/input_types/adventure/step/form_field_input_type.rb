# frozen_string_literal: true

class InputTypes::Adventure::Step::FormFieldInputType < Types::BaseInputObject
  graphql_name 'AdventureStepFormFieldInput'
  description 'Attributes for creating a formField'
  argument :id, ID, required: true
  argument :name, String, required: true
  argument :required, Boolean, required: true
  argument :_destroy, Boolean, required: false
end
