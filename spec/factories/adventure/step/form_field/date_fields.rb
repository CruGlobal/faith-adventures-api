# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_step_form_field_date_field, class: 'Adventure::Step::FormField::DateField' do
    association :step, factory: :adventure_step
    name { Faker::Name.name }
    required { false }
  end
end
