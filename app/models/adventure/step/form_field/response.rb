# frozen_string_literal: true

class Adventure::Step::FormField::Response < ApplicationRecord
  belongs_to :form_field
  belongs_to :user
  validate :value_is_valid
  validates :form_field_id, uniqueness: { scope: :user_id, case_sensitive: false }

  private

  def value_is_valid
    form_field&.validate_value(self)
  end
end
