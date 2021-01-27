# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure::Step::FormField, type: :model do
  subject(:form_field) { create(:adventure_step_form_field_string_field).becomes(described_class) }

  it { is_expected.to belong_to(:step) }
  it { is_expected.to have_many(:responses) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:name) }

  describe '#validate_value' do
    let(:response) { build(:adventure_step_form_field_response, form_field: form_field, value: nil) }

    it 'is valid' do
      form_field.validate_value(response)
      expect(form_field.validate_value(response).errors).to be_empty
    end

    context 'when required' do
      subject(:form_field) { create(:adventure_step_form_field_string_field, required: true) }

      it 'is not valid' do
        expect(form_field.validate_value(response).errors).not_to be_empty
      end
    end
  end

  describe '#add_validation_errors' do
    it 'responds' do
      expect(form_field).to respond_to(:add_validation_errors)
    end
  end
end
