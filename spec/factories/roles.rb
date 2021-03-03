# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    association :resource, factory: :adventure
  end
end
