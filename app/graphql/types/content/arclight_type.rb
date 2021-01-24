# frozen_string_literal: true

class Types::Content::ArclightType < Types::BaseRecord
  implements Types::ContentInterface

  field :media_component_id, String, null: false
  field :media_language_id, String, null: false
  field :duration, Integer, null: false
  field :picture_small_url, String, null: false
  field :picture_medium_url, String, null: false
  field :picture_large_url, String, null: false
  field :hls_url, String, null: false
end
