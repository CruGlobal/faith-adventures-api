# frozen_string_literal: true

module Types::BaseInterface
  include GraphQL::Schema::Interface

  field_class Types::BaseField
end
