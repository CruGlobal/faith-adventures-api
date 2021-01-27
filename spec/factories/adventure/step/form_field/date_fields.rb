# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_step_form_field_date_field, class: 'Adventure::Step::FormField::DateField' do
    association :step, factory: :adventure_step
    name { Faker::Name.name }

    trait :complete do
      min_date { '2011-10-05' }
      max_date { '2020-09-20' }
      required { true }
    end
  end
end
