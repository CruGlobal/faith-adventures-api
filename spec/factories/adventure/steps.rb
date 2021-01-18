# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_step, class: 'Adventure::Step' do
    adventure
    association :content, factory: :content_arclight
  end
end
