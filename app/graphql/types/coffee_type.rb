# frozen_string_literal: true

class Types::CoffeeType < Types::BaseRecord
  field :lat, type: Float, null: true
  field :lng, type: Float, null: true
  field :tip, type: Types::TipType, null: true
  field :tip_completed_at, GraphQL::Types::ISO8601DateTime, null: true
end
