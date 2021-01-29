# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_step_form_field_radio_field, class: 'Adventure::Step::FormField::RadioField' do
    association :step, factory: :adventure_step
    name { Faker::Name.name }
    options { [] }

    trait :complete do
      options { %w[abc def] }
      required { true }
    end
  end
end
