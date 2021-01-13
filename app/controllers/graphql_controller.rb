# frozen_string_literal: true

class GraphqlController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def execute
    render json: json_response
  end

  private

  def json_response
    FaithAdventureSchema.execute(
      params[:query],
      variables: variables,
      context: context,
      operation_name: params[:operationName]
    )
  end

  def variables(variable_params = params[:variables])
    return {} if variable_params.nil?

    case variable_params
    when String
      return variable_params.present? ? JSON.parse(variable_params) || {} : {}
    when Hash
      return variable_params
    when ActionController::Parameters
      return variable_params.to_unsafe_hash
    end
    raise ArgumentError, "Unexpected parameter: #{variable_params}"
  end

  def context
    @context ||= {
      current_user: current_user
    }
  end

  def current_user
    authenticate_with_http_token { |token| User.from_token(token) }
  rescue JWT::IncorrectAlgorithm
    nil
  end
end
