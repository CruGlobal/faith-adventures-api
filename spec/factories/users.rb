# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sub { Faker::Alphanumeric.unique.alphanumeric(number: 10, min_alpha: 3) }

    trait :complete do
      given_name { Faker::Name.first_name }
      family_name { Faker::Name.last_name }
      nickname { Faker::Internet.username }
      name { Faker::Name.name }
      picture { Faker::LoremFlickr.image }
      locale { 'en' }
      email { Faker::Internet.email }
      email_verified { true }
    end
  end
end
