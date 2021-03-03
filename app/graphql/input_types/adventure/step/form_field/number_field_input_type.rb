# frozen_string_literal: true

class InputTypes::Adventure::Step::FormField::NumberFieldInputType < Types::BaseInputObject
  argument :max, Integer, required: false
  argument :min, Integer, required: false
end
