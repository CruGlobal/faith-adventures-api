# frozen_string_literal: true

class Types::AdventureType < Types::BaseRecord
  field :name, type: String, null: false
  field :slug, type: String, null: false
  field :tag_list, type: [String], null: false
  field :description, type: String, null: true
  field :locale, type: Types::LocaleEnum, null: false
  field :content, type: Types::ContentInterface, null: false

  def tag_list
    object.tag_list.sort
  end
end
