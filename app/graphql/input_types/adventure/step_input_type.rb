# frozen_string_literal: true

class InputTypes::Adventure::StepInputType < Types::BaseInputObject
  graphql_name 'AdventureStepInput'
  description 'Attributes for creating or updating a step'
  argument :id, ID, required: true
  argument :name, String, required: true
  argument :content_id, ID, required: true
  argument :after_response_message, String, required: false
  argument :before_response_message, String, required: false
end
