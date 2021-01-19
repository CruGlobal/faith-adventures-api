# frozen_string_literal: true

class Types::QueryType < Types::BaseObject
  field :adventures, resolver: Queries::AdventuresQuery
  field :me, resolver: Queries::MeQuery
end
