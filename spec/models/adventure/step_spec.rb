# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure::Step, type: :model do
  subject(:step) { create(:adventure_step) }

  it { is_expected.to belong_to(:adventure) }
  it { is_expected.to belong_to(:content) }
end
