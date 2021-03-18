# frozen_string_literal: true

FactoryBot.define do
  factory :content_like, class: 'Content::Like' do
    association :content, factory: %i[content_arclight complete]
    user
  end
end
