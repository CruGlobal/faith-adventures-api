# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_step_form_field_string_field, class: 'Adventure::Step::FormField::StringField' do
    association :step, factory: :adventure_step
    name { Faker::Name.name }

    trait :complete do
      min_length { '10' }
      max_length { '20' }
      required { true }
    end
  end
end
