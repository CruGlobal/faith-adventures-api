# frozen_string_literal: true

class Content::Like < ApplicationRecord
  belongs_to :content, counter_cache: true
  belongs_to :user
  validates :content_id, { uniqueness: { scope: :user_id } }
  after_commit :destroy_dislike, on: :create

  private

  def destroy_dislike
    content.dislikes.find_by(user: user)&.delete
  end
end
