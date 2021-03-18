# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Content::Dislike, type: :model do
  subject(:dislike) { create(:content_dislike) }

  it { is_expected.to belong_to(:content).counter_cache(true) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:content_id).scoped_to(:user_id).case_insensitive }

  describe '#destroy_like' do
    subject(:dislike) { create(:content_dislike, user: user, content: content) }

    let(:content) { create(:content_arclight, :complete) }
    let(:user) { create(:user) }
    let!(:like) { create(:content_like, user: user, content: content) }

    it 'destroys existing like' do
      dislike
      expect { like.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
