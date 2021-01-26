# frozen_string_literal: true

class Adventure::Step < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  acts_as_list scope: [:adventure_id]
  belongs_to :adventure
  belongs_to :content
  has_many :form_fields, dependent: :delete_all
  has_many :responses, through: :form_fields
  validates :name, presence: true
end
