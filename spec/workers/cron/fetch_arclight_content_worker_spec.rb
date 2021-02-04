# frozen_string_literal: true

require 'rails_helper'

vcr_options = { cassette_name: 'content/arclight', match_requests_on: [:uri] }
RSpec.describe Cron::FetchArclightContentWorker, type: :worker, vcr: vcr_options do
  it { is_expected.to be_processed_in :low }

  describe '#perform' do
    let(:query) { "metadata->>'media_component_id' = '1_jf-0-0' AND metadata->>'media_language_id' = '529'" }

    it 'creates content' do
      described_class.new.perform
      expect(Content::Arclight.where(query)).to exist
    end

    context 'when content already exists' do
      before { create(:content_arclight, :complete) }

      it 'does not create content' do
        expect { described_class.new.perform }.not_to change(Content::Arclight, :count)
      end
    end
  end
end
