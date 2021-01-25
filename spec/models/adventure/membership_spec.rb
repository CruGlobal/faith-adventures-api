# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure::Membership, type: :model do
  subject(:membership) { create(:adventure_membership) }

  it { is_expected.to belong_to(:adventure) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:adventure_id).scoped_to(:user_id).case_insensitive }
end
