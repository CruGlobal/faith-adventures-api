# frozen_string_literal: true

class FaithAdventureSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST
  use GraphQL::Execution::Errors
  use GraphQL::Pagination::Connections
  use GraphQL::Batch

  rescue_from(ActiveRecord::RecordNotFound) do |err, _obj, _args, _ctx, _field|
    raise GraphQL::ExecutionError.new(
      "#{err.model} with id=#{err.id} not found",
      extensions: { code: 'NOT_FOUND' }
    )
  end

  rescue_from(ActiveRecord::RecordInvalid) do |err, _obj, _args, _ctx, _field|
    raise GraphQL::ExecutionError.new(
      err.message,
      extensions: {
        'code' => 'INVALID',
        'errors' => err.record.errors.messages.transform_keys { |key| key.to_s.camelize(:lower) }
      }
    )
  end

  rescue_from(Pundit::NotAuthorizedError) do |err, _obj, _args, _ctx, _field|
    raise GraphQL::ExecutionError.new(
      err.message,
      extensions: { code: 'UNAUTHORIZED' }
    )
  end
end
