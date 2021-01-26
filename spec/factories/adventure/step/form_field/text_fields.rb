# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_step_form_field_text_field, class: 'Adventure::Step::FormField::TextField' do
    association :step, factory: :adventure_step
    name { Faker::Name.name }
    required { false }
  end
end
