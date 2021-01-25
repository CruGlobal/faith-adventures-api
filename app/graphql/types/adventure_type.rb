# frozen_string_literal: true

class Types::AdventureType < Types::BaseRecord
  field :name, type: String, null: false
  field :slug, type: String, null: false
  field :tag_list, type: [String], null: false
  field :description, type: String, null: true
  field :locale, type: Types::LocaleEnum, null: false
  field :content, type: Types::ContentInterface, null: false
  field :steps, type: Types::Adventure::StepType.connection_type, null: false
  field :solo_adventure, type: Types::AdventureType, null: true
  field :template, type: Types::AdventureType, null: true

  def tag_list
    object.tag_list.sort
  end

  def solo_adventure
    context[:current_user] ? object.solo_adventure(context[:current_user]) : nil
  end
end
