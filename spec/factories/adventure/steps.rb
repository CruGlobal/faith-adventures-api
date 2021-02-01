# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_step, class: 'Adventure::Step' do
    adventure
    association :content, factory: %i[content_arclight complete]
    name { Faker::Name.name }

    trait :complete do
      before_response_message { Faker::Company.catch_phrase }
      after_response_message { Faker::Company.catch_phrase }
    end
  end
end
