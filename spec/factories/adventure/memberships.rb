# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_membership, class: 'Adventure::Membership' do
    user
    adventure
  end
end
