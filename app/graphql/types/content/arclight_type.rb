# frozen_string_literal: true

class Types::Content::ArclightType < Types::BaseRecord
  implements Types::ContentInterface

  field :media_component_id, String, null: false
  field :media_language_id, String, null: false
end
