# frozen_string_literal: true

class Types::QueryType < Types::BaseObject
  field :me, resolver: Queries::MeQuery
end
