# frozen_string_literal: true

class Adventure < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :content
  belongs_to :template, class_name: 'Adventure', optional: true
  has_many :children, class_name: 'Adventure', foreign_key: :template_id, dependent: :delete_all
  has_many :steps, dependent: :delete_all
  validates :name, :locale, presence: true
  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s) }
end
