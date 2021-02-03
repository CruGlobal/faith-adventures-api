# frozen_string_literal: true

require 'rails_helper'

vcr_options = { cassette_name: 'content/arclight', match_requests_on: [:uri] }
RSpec.describe Content::Arclight, type: :model, vcr: vcr_options do
  subject(:arclight) { create(:content_arclight) }

  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:media_component_id) }
  it { is_expected.to validate_presence_of(:media_language_id) }
  it { is_expected.to validate_presence_of(:locale) }
  it { is_expected.to validate_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }

  describe '#set_attributes' do
    it 'sets name' do
      expect(arclight.name).to eq 'JESUS'
    end

    it 'sets description' do
      expect(arclight.description).to eq(
        'Jesus constantly surprises and confounds people, from His miraculous birth to His rise from the grave. '\
        'Follow His life through excerpts from the Book of Luke, all the miracles, the teachings, and the passion.'
      )
    end

    it 'sets duration' do
      expect(arclight.duration).to eq 7_673_754
    end
  end

  describe '#set_picture_urls' do
    it 'sets picture_small_url' do
      expect(arclight.picture_small_url).to eq(
        'https://d1wl257kev7hsz.cloudfront.net/cinematics/1_jf-0-0.mobileCinematicVeryLow.webp'
      )
    end

    it 'sets picture_medium_url' do
      expect(arclight.picture_medium_url).to eq(
        'https://d1wl257kev7hsz.cloudfront.net/cinematics/1_jf-0-0.mobileCinematicLow.jpg'
      )
    end

    it 'sets picture_large_url' do
      expect(arclight.picture_large_url).to eq(
        'https://d1wl257kev7hsz.cloudfront.net/cinematics/1_jf-0-0.mobileCinematicHigh.jpg'
      )
    end
  end

  describe '#set_hls_url' do
    it 'sets hls_url' do
      expect(arclight.hls_url).to eq 'https://arc.gt/j67rz?apiSessionId=1234567890'
    end
  end
end
