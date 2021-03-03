# frozen_string_literal: true

class InputTypes::Adventure::Step::FormField::RadioFieldInputType < Types::BaseInputObject
  argument :options, [String], required: true
end
