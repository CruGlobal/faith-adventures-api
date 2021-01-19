# frozen_string_literal: true

FactoryBot.define do
  factory :adventure do
    association :content, factory: :content_arclight
    name { Faker::Name.name }
    locale { I18n.available_locales.map(&:to_s).sample }

    trait :complete do
      description { Faker::Company.catch_phrase }
    end
  end
end
