# frozen_string_literal: true

class Content < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  acts_as_taggable_on :tags
  has_many :views, dependent: :delete_all
  validates :name, :locale, :type, presence: true
  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s) }
  scope :published, -> { where(published: true) }
  scope :featured, -> { where(featured: true) }

  def slug_candidates
    [:name, %i[name locale]]
  end
end
