# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure::Step::FormField::Response, type: :model do
  subject(:response) { build(:adventure_step_form_field_response, form_field: form_field) }

  let(:form_field) { create(:adventure_step_form_field_text_field) }

  it { is_expected.to belong_to(:form_field) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:form_field_id).scoped_to(:user_id).case_insensitive }

  describe '#value_is_valid' do
    it 'calls validate_value' do
      allow(form_field).to receive(:validate_value)
      response.valid?
      expect(form_field).to have_received(:validate_value).with(response)
    end
  end
end
