# frozen_string_literal: true

class Adventure::Membership < ApplicationRecord
  belongs_to :user
  belongs_to :adventure
  validates :adventure_id, uniqueness: { scope: :user_id, case_sensitive: false }
end
