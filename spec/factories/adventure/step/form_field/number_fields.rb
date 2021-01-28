# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_step_form_field_number_field, class: 'Adventure::Step::FormField::NumberField' do
    association :step, factory: :adventure_step
    name { Faker::Name.name }

    trait :complete do
      min { '10' }
      max { '20' }
      required { true }
    end
  end
end
