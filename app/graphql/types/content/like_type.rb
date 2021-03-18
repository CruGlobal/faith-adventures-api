# frozen_string_literal: true

class Types::Content::LikeType < Types::BaseRecord
  field :content, Types::ContentInterface, null: false
  field :user, Types::UserType, null: false
end
