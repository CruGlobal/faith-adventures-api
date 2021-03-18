# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Content::View, type: :model do
  subject(:view) { create(:content_view) }

  it { is_expected.to belong_to(:content).counter_cache(true) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:content_id).scoped_to(:user_id).case_insensitive }
end
