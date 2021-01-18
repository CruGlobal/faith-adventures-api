# frozen_string_literal: true

FactoryBot.define do
  factory :content do
    name { Faker::Name.name }
    locale { I18n.available_locales.map(&:to_s).sample }
  end
end
