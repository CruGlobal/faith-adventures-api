# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adventure::Step, type: :model do
  subject(:step) { create(:adventure_step) }

  it { is_expected.to belong_to(:adventure) }
  it { is_expected.to belong_to(:content) }
  it { is_expected.to have_many(:form_fields).dependent(:delete_all) }
  it { is_expected.to have_many(:responses).through(:form_fields) }
  it { is_expected.to validate_presence_of(:name) }
end
