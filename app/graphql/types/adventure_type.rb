# frozen_string_literal: true

class Types::AdventureType < Types::BaseRecord
  field :name, type: String, null: false
  field :slug, type: String, null: false
  field :tag_list, type: [String], null: false
  field :description, type: String, null: true
  field :locale, type: Types::LocaleEnum, null: false
  field :content, type: Types::ContentInterface, null: false
  field :steps, type: Types::Adventure::StepType.connection_type, null: false
  field :template, type: Types::AdventureType, null: true
  field :children, type: Types::AdventureType.connection_type, null: false
  field :users, type: Types::UserType.connection_type, null: false

  def tag_list
    object.tag_list.sort
  end

  def children
    return object.children.joins(:users).where(users: { id: context[:current_user].id }) if context[:current_user]

    Adventure.none
  end
end
