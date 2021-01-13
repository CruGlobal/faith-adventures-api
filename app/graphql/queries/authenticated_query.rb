# frozen_string_literal: true

class Queries::AuthenticatedQuery < Queries::ApplicationQuery
  def authorized?(**_args)
    return super if context[:current_user]

    raise Pundit::NotAuthorizedError
  end
end
