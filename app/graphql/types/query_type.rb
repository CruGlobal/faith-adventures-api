# frozen_string_literal: true

class Types::QueryType < Types::BaseObject
  field :adventures, resolver: Queries::AdventuresQuery
  field :adventure, resolver: Queries::AdventureQuery
  field :me, resolver: Queries::MeQuery
end
