# frozen_string_literal: true

class InputTypes::Adventure::Step::FormField::StringFieldInputType < Types::BaseInputObject
  argument :max_length, Integer, required: false
  argument :min_length, Integer, required: false
end
