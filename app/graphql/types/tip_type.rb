# frozen_string_literal: true

class Types::TipType < Types::BaseRecord
  field :name, type: String, null: false
  field :description, type: String, null: false
end
