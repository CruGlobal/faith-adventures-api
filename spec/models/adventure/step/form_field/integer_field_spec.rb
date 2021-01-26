# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure::Step::FormField::IntegerField, type: :model do
  subject(:form_field) { create(:adventure_step_form_field_integer_field) }

  it { is_expected.to allow_values('0', '-1', '+1', '1').for(:min) }
  it { is_expected.not_to allow_values('abc', 'def1', '1ghi').for(:min).with_message('must be a valid number') }

  it { is_expected.to allow_values('0', '-1', '+1', '1').for(:max) }
  it { is_expected.not_to allow_values('abc', 'def1', '1ghi').for(:max).with_message('must be a valid number') }

  describe '#add_validation_errors' do
    let(:value) { nil }
    let(:response) { build(:adventure_step_form_field_response, form_field: form_field, value: value) }

    it 'is valid' do
      form_field.add_validation_errors(response)
      expect(response.errors).to be_empty
    end

    context 'when integer format is valid' do
      let(:value) { '1' }

      it 'is valid' do
        form_field.add_validation_errors(response)
        expect(response.errors).to be_empty
      end
    end

    context 'when integer format is invalid' do
      let(:value) { 'incorrect integer format' }

      it 'is invalid' do
        form_field.add_validation_errors(response)
        expect(response.errors[:value].first).to eq 'must be a valid number'
      end
    end

    context 'when integer is less than min' do
      subject(:form_field) { create(:adventure_step_form_field_integer_field, min: '20') }

      let(:value) { '10' }

      it 'is invalid' do
        form_field.add_validation_errors(response)
        expect(response.errors[:value].first).to eq "can't be less than 20"
      end
    end

    context 'when integer is greater than than max' do
      subject(:form_field) { create(:adventure_step_form_field_integer_field, max: '10') }

      let(:value) { '20' }

      it 'is invalid' do
        form_field.add_validation_errors(response)
        expect(response.errors[:value].first).to eq "can't be greater than 10"
      end
    end
  end
end
