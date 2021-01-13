# frozen_string_literal: true

class Mutations::BaseMutation < GraphQL::Schema::RelayClassicMutation
  argument_class Types::BaseArgument
  field_class Types::BaseField
  input_object_class Types::BaseInputObject
  object_class Types::BaseObject

  def ready?(**_args)
    return true if context[:current_user]

    raise GraphQL::ExecutionError.new('permission denied', extensions: { code: 'AUTHENTICATION_ERROR' })
  end
end
