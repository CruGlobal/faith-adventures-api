# frozen_string_literal: true

class Mutations::Adventure::Step::FormField::CreateMutation < Mutations::AuthenticatedMutation
  graphql_name 'AdventureStepFormFieldCreateMutation'
  argument :step_id, ID, required: true
  argument :attributes, InputTypes::Adventure::Step::FormFieldInputType, required: true
  field :form_field, Types::Adventure::Step::FormFieldInterface, null: false

  def resolve(step_id:, attributes:)
    step = Adventure::Step.find(step_id)
    raise GraphQL::ExecutionError, 'owners only' unless context[:current_user].has_role?(:owner, step.adventure)

    form_field = step.form_fields.create!(format_attributes(attributes.to_h))
    { form_field: form_field }
  end

  protected

  def format_attributes(attributes)
    case attributes[:type]
    when 'Adventure::Step::FormField::DateField'
      attributes.slice!(:date_field).merge(attributes[:date_field])
    when 'Adventure::Step::FormField::NumberField'
      attributes.slice!(:number_field).merge(attributes[:number_field])
    when 'Adventure::Step::FormField::RadioField'
      attributes.slice!(:radio_field).merge(attributes[:radio_field])
    when 'Adventure::Step::FormField::StringField'
      attributes.slice!(:string_field).merge(attributes[:string_field])
    end
  end
end
