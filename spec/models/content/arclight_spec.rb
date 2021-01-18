# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Content::Arclight, type: :model do
  subject(:arclight) { create(:content_arclight) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:media_component_id) }
  it { is_expected.to validate_presence_of(:media_language_id) }
  it { is_expected.to validate_presence_of(:locale) }
  it { is_expected.to validate_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }
end
