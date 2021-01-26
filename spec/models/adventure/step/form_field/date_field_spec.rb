# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure::Step::FormField::DateField, type: :model do
  subject(:form_field) { create(:adventure_step_form_field_date_field) }

  describe '#add_validation_errors' do
    let(:value) { nil }
    let(:response) { build(:adventure_step_form_field_response, form_field: form_field, value: value) }

    it 'is valid' do
      form_field.add_validation_errors(response)
      expect(response.errors).to be_empty
    end

    context 'when date format is valid' do
      let(:value) { '1985-10-01' }

      it 'is valid' do
        form_field.add_validation_errors(response)
        expect(response.errors).to be_empty
      end
    end

    context 'when date format is invalid' do
      let(:value) { 'incorrect date format' }

      it 'is invalid' do
        form_field.add_validation_errors(response)
        expect(response.errors[:value].first).to eq 'must be a valid date'
      end
    end

    context 'when date is less than min' do
      subject(:form_field) { create(:adventure_step_form_field_date_field, min: '2011-10-01') }

      let(:value) { '1985-10-01' }

      it 'is invalid' do
        form_field.add_validation_errors(response)
        expect(response.errors[:value].first).to eq "can't be before 2011-10-01"
      end
    end

    context 'when date is greater than than max' do
      subject(:form_field) { create(:adventure_step_form_field_date_field, max: '1985-10-01') }

      let(:value) { '2011-10-01' }

      it 'is invalid' do
        form_field.add_validation_errors(response)
        expect(response.errors[:value].first).to eq "can't be after 1985-10-01"
      end
    end
  end

  describe '#validate_min_valid_value' do
    subject(:form_field) { build(:adventure_step_form_field_date_field, min: nil) }

    it 'is valid' do
      expect(form_field).to be_valid
    end

    context 'when date format is valid' do
      subject(:form_field) { build(:adventure_step_form_field_date_field, min: '1985-10-01') }

      it 'is valid' do
        expect(form_field).to be_valid
      end
    end

    context 'when date format is invalid' do
      subject(:form_field) { build(:adventure_step_form_field_date_field, min: 'incorrect date format') }

      it 'is invalid' do
        expect(form_field).not_to be_valid
      end
    end
  end

  describe '#validate_max_valid_value' do
    subject(:form_field) { build(:adventure_step_form_field_date_field, max: nil) }

    it 'is valid' do
      expect(form_field).to be_valid
    end

    context 'when date format is valid' do
      subject(:form_field) { build(:adventure_step_form_field_date_field, max: '1985-10-01') }

      it 'is valid' do
        expect(form_field).to be_valid
      end
    end

    context 'when date format is invalid' do
      subject(:form_field) { build(:adventure_step_form_field_date_field, max: 'incorrect date format') }

      it 'is invalid' do
        expect(form_field).not_to be_valid
      end
    end
  end
end
