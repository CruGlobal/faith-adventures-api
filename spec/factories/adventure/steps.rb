# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_step, class: 'Adventure::Step' do
    adventure
    association :content, factory: %i[content_arclight complete]
    name { Faker::Name.name }
  end
end
