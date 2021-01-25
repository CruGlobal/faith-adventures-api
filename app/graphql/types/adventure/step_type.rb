# frozen_string_literal: true

class Types::Adventure::StepType < Types::BaseRecord
  field :name, type: String, null: false
  field :slug, type: String, null: false
  field :content, type: Types::ContentInterface, null: false
end
