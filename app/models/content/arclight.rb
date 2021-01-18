# frozen_string_literal: true

class Content::Arclight < Content
  store_accessor :metadata, :media_component_id, :media_language_id
  validates :media_component_id, :media_language_id, presence: true
end
