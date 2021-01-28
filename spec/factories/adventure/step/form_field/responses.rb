# frozen_string_literal: true

FactoryBot.define do
  factory :adventure_step_form_field_response, class: 'Adventure::Step::FormField::Response' do
    association :form_field, factory: :adventure_step_form_field_string_field
    user
  end
end
