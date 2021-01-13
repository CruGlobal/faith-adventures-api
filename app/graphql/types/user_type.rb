# frozen_string_literal: true

class Types::UserType < Types::BaseRecord
  field :name, type: String, null: true
  field :picture, type: String, null: true
end
