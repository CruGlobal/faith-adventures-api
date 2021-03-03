# frozen_string_literal: true

class Mutations::Adventure::Step::FormField::DestroyMutation < Mutations::AuthenticatedMutation
  graphql_name 'AdventureStepFormFieldDestroyMutation'
  argument :id, ID, required: true
  field :id, ID, null: false

  def resolve(id:)
    form_field = Adventure::Step::FormField.find(id)
    unless context[:current_user].has_role?(:owner, form_field.step.adventure)
      raise GraphQL::ExecutionError, 'owners only'
    end

    form_field.destroy!
    { id: id }
  end
end
