# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cron::FetchFirebaseCertificatesWorker, type: :worker do
  it { is_expected.to be_processed_in :low }

  describe '#perform' do
    it 'calls request!' do
      allow(FirebaseIdToken::Certificates).to receive(:request!)
      described_class.new.perform

      expect(FirebaseIdToken::Certificates).to have_received(:request!)
    end
  end
end
