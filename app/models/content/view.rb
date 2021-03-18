# frozen_string_literal: true

class Content::View < ApplicationRecord
  belongs_to :content, counter_cache: true
  belongs_to :user
  validates :content_id, { uniqueness: { scope: :user_id } }
end
