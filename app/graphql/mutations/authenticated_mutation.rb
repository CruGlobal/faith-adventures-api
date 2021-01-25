# frozen_string_literal: true

class Mutations::AuthenticatedMutation < Mutations::BaseMutation
  def ready?(**_args)
    return true if context[:current_user]

    raise GraphQL::ExecutionError.new('permission denied', extensions: { code: 'AUTHENTICATION_ERROR' })
  end
end
