# frozen_string_literal: true

class Adventure::Step < ApplicationRecord
  acts_as_list scope: [:adventure_id]
  belongs_to :adventure
  belongs_to :content
end
