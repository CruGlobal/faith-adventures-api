# frozen_string_literal: true

class Types::Content::DislikeType < Types::BaseRecord
  field :content, Types::ContentInterface, null: false
  field :user, Types::UserType, null: false
end
