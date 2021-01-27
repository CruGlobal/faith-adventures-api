# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure::Step::FormField::StringField, type: :model do
  subject(:form_field) { create(:adventure_step_form_field_string_field) }

  it { is_expected.to allow_values('0', '-1', '+1', '1').for(:min_length) }
  it { is_expected.not_to allow_values('abc', 'def1', '1ghi').for(:min_length).with_message('must be a valid number') }

  it { is_expected.to allow_values('0', '-1', '+1', '1').for(:max_length) }
  it { is_expected.not_to allow_values('abc', 'def1', '1ghi').for(:max_length).with_message('must be a valid number') }

  describe '#add_validation_errors' do
    let(:value) { nil }
    let(:response) { build(:adventure_step_form_field_response, form_field: form_field, value: value) }

    it 'is valid' do
      form_field.add_validation_errors(response)
      expect(response.errors).to be_empty
    end

    context 'when text format is valid' do
      let(:value) { 'abc' }

      it 'is valid' do
        form_field.add_validation_errors(response)
        expect(response.errors).to be_empty
      end
    end

    context 'when text is less than min_length' do
      subject(:form_field) { create(:adventure_step_form_field_string_field, min_length: '20') }

      let(:value) { 'abc' }

      it 'is invalid' do
        form_field.add_validation_errors(response)
        expect(response.errors[:value].first).to eq "can't be shorter than 20"
      end
    end

    context 'when text is greater than than max_length' do
      subject(:form_field) { create(:adventure_step_form_field_string_field, max_length: '10') }

      let(:value) { 'abcdefhijklm' }

      it 'is invalid' do
        form_field.add_validation_errors(response)
        expect(response.errors[:value].first).to eq "can't be longer than 10"
      end
    end
  end
end
