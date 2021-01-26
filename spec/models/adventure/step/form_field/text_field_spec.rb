# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure::Step::FormField::TextField, type: :model do
  subject(:form_field) { create(:adventure_step_form_field_text_field) }

  it { is_expected.to validate_absence_of(:max) }
  it { is_expected.to validate_absence_of(:min) }
end
