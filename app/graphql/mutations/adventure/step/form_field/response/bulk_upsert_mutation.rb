# frozen_string_literal: true

class Mutations::Adventure::Step::FormField::Response::BulkUpsertMutation < Mutations::AuthenticatedMutation
  class ResponseInputType < Types::BaseInputObject
    graphql_name 'AdventureStepFormFieldResponseBulkUpsertMutationInputType'
    description 'Attributes for creating or updating a response'
    argument :id,
             ID,
             required: false,
             description: 'this will overwrite any existing response from the user for the same formField'
    argument :form_field_id, ID, required: true
    argument :value, String, required: true
  end

  graphql_name 'AdventureStepFormFieldResponseBulkUpsertMutation'
  argument :step_id, ID, required: true, description: 'Can be ID or slug'
  argument :attributes, [ResponseInputType], required: true
  field :responses, [Types::Adventure::Step::FormField::ResponseType], null: false
  field :step, Types::Adventure::StepType, null: false

  def resolve(step_id:, attributes:)
    step = context[:current_user].steps.friendly.find(step_id)
    responses = attributes.map { |attrs| upsert_response(step, attrs) }
    { step: step, responses: responses }
  end

  def upsert_response(step, attributes)
    response = step.form_fields.find(attributes.form_field_id)
                   .responses
                   .find_or_initialize_by(user: context[:current_user])
    response.attributes = attributes.to_h.except(:form_field_id)
    response.save!
    response
  end
end
