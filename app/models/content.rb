# frozen_string_literal: true

class Content < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  acts_as_taggable_on :tags
  validates :name, :locale, :type, presence: true
  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s) }
  store :metadata, coder: JSON
end
