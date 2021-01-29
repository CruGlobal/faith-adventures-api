# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure::Step::FormField::RadioField, type: :model do
  subject(:form_field) { create(:adventure_step_form_field_radio_field, options: ['abc']) }

  it { is_expected.to allow_values([], ['abc'], %w[abc def]).for(:options) }
  it { is_expected.not_to allow_values('abc').for(:options).with_message('must be an array') }
  it { is_expected.not_to allow_values([1], [{}]).for(:options).with_message('must be an array of strings') }

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

    context 'when text is not included in options' do
      let(:value) { 'def' }

      it 'is invalid' do
        form_field.add_validation_errors(response)
        expect(response.errors[:value].first).to eq "can't be outside of available options"
      end
    end
  end
end
