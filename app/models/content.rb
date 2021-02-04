# frozen_string_literal: true

class Content < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  acts_as_taggable_on :tags
  validates :name, :locale, :type, presence: true
  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s) }

  def slug_candidates
    [:name, %i[name locale]]
  end
end
