# frozen_string_literal: true

FactoryBot.define do
  factory :content_dislike, class: 'Content::Dislike' do
    association :content, factory: %i[content_arclight complete]
    user
  end
end
