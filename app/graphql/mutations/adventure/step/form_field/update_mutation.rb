# frozen_string_literal: true

class Mutations::Adventure::Step::FormField::UpdateMutation < Mutations::AuthenticatedMutation
  class FormFieldUpdateInputType < InputTypes::Adventure::Step::FormFieldInputType
    graphql_name 'AdventureStepFormFieldUpdateInput'
    argument :id, ID, required: true
  end

  graphql_name 'AdventureStepFormFieldUpdateMutation'
  argument :attributes, FormFieldUpdateInputType, required: true
  field :form_field, Types::Adventure::Step::FormFieldInterface, null: false

  def resolve(attributes:)
    form_field = Adventure::Step::FormField.find(attributes.id).becomes(attributes[:type].constantize)
    unless context[:current_user].has_role?(:owner, form_field.step.adventure)
      raise GraphQL::ExecutionError, 'owners only'
    end

    form_field.update!(format_attributes(attributes.to_h))
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
