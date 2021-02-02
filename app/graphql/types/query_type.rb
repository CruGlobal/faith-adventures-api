# frozen_string_literal: true

class Types::QueryType < Types::BaseObject
  field :adventures, resolver: Queries::AdventuresQuery
  field :adventure, resolver: Queries::AdventureQuery
  field :adventure_step, resolver: Queries::Adventure::StepQuery
  field :contents, resolver: Queries::ContentsQuery
  field :content, resolver: Queries::ContentQuery
  field :me, resolver: Queries::MeQuery
end
