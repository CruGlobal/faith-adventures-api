# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure, type: :model do
  subject(:adventure) { create(:adventure) }

  it { is_expected.to belong_to(:content) }
  it { is_expected.to belong_to(:template).optional }
  it { is_expected.to have_many(:children).dependent(:delete_all) }
  it { is_expected.to have_many(:steps).dependent(:delete_all) }
  it { is_expected.to have_many(:memberships).dependent(:delete_all) }
  it { is_expected.to have_many(:users).through(:memberships) }
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

  describe '.featured' do
    let(:adventure) { create(:adventure, featured: true) }

    before do
      create(:adventure, featured: false)
      create(:adventure, featured: true, template: create(:adventure))
    end

    it 'returns featured with no template' do
      expect(described_class.featured).to eq [adventure]
    end
  end

  describe '#start' do
    subject(:adventure) { create(:adventure, :complete, published: true, featured: true) }

    let(:user) { create(:user) }
    let(:clone) { adventure.start(user) }

    before { create(:adventure_step, adventure: adventure) }

    it 'copies attributes to clone' do
      expect(clone.attributes).to include(
        adventure.attributes.except('id', 'slug', 'created_at', 'updated_at', 'template_id', 'featured', 'published')
      )
    end

    it 'sets attributes on clone' do
      expect(clone.attributes).to include(
        'template_id' => adventure.id,
        'published' => nil,
        'featured' => nil
      )
    end

    it 'sets user' do
      expect(clone.users).to eq [user]
    end

    it 'copies step association attributes' do
      expect(clone.steps.first.attributes).to include(
        adventure.steps.first.attributes.except('id', 'slug', 'created_at', 'updated_at', 'adventure_id')
      )
    end

    context 'when child' do
      subject(:adventure) { create(:adventure, template: create(:adventure)) }

      it 'returns self' do
        expect(clone).to eq adventure
      end
    end

    context 'when template has already been copied by user' do
      let!(:existing_clone) { adventure.start(user) }

      it 'returns existing clone' do
        expect(clone).to eq existing_clone
      end
    end
  end

  describe '#solo_adventure' do
    let(:clone) { adventure.start(user) }
    let(:user) { create(:user) }

    before do
      group_adventure = adventure.start(user)
      group_adventure.users << create(:user)
      clone
    end

    it 'returns solo_adventure' do
      expect(adventure.solo_adventure(user)).to eq clone
    end
  end
end
