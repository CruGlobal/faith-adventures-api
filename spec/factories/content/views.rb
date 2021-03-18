# frozen_string_literal: true

FactoryBot.define do
  factory :content_view, class: 'Content::View' do
    association :content, factory: %i[content_arclight complete]
    user
  end
end
