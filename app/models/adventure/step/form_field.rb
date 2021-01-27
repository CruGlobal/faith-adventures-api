# frozen_string_literal: true

class Adventure::Step::FormField < ApplicationRecord
  belongs_to :step
  has_many :responses, dependent: :delete_all, class_name: 'Adventure::Step::FormField::Response'
  validates :type, :name, presence: true
  acts_as_list scope: [:step_id]
  store :metadata, coder: JSON

  def validate_value(response)
    response.errors.add :value, "can't be blank" if required? && response.value.blank?

    add_validation_errors(response)
    response
  end

  def add_validation_errors(response); end
end
