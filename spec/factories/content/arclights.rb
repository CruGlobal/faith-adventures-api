# frozen_string_literal: true

FactoryBot.define do
  factory :content_arclight, class: 'Content::Arclight', parent: :content do
    metadata { { media_component_id: '1_jf-0-0', media_language_id: '529' } }
  end
end
