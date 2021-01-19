# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure, type: :model do
  subject(:adventure) { create(:adventure) }

  it { is_expected.to belong_to(:content) }
  it { is_expected.to belong_to(:template).optional }
  it { is_expected.to have_many(:children).dependent(:delete_all) }
  it { is_expected.to have_many(:steps).dependent(:delete_all) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:locale) }
  it { is_expected.to validate_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }

  describe '.published' do
    let(:adventure) { create(:adventure, published: true) }

    before do
      create(:adventure, published: false)
      create(:adventure, published: true, template: create(:adventure))
    end

    it 'returns published with no template' do
      expect(described_class.published).to eq [adventure]
    end
  end
end
