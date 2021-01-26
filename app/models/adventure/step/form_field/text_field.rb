# frozen_string_literal: true

class Adventure::Step::FormField::TextField < Adventure::Step::FormField
  validates :max, :min, absence: true
end
