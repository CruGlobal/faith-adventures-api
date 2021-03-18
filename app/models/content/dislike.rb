# frozen_string_literal: true

class Content::Dislike < ApplicationRecord
  belongs_to :content, counter_cache: true
  belongs_to :user
  validates :content_id, { uniqueness: { scope: :user_id } }
  after_commit :destroy_like, on: :create

  private

  def destroy_like
    content.likes.find_by(user: user)&.destroy
  end
end
