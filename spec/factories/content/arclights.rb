# frozen_string_literal: true

FactoryBot.define do
  factory :content_arclight, class: 'Content::Arclight', parent: :content do
    metadata { { media_component_id: '1_jf-0-0', media_language_id: '529' } }

    trait :complete do
      metadata_payload do
        {
          'imageUrls' => {
            'mobileCinematicHigh' => 'https://d1wl257kev7hsz.cloudfront.net/cinematics/1_jf-0-0.mobileCinematicHigh.jpg',
            'mobileCinematicLow' => 'https://d1wl257kev7hsz.cloudfront.net/cinematics/1_jf-0-0.mobileCinematicLow.jpg',
            'mobileCinematicVeryLow' => 'https://d1wl257kev7hsz.cloudfront.net/cinematics/1_jf-0-0.mobileCinematicVeryLow.webp'
          },
          'lengthInMilliseconds' => 7_673_754,
          'title' => 'JESUS',
          'shortDescription' =>
            'Jesus constantly surprises and confounds people, from His miraculous birth to His rise from the grave. '\
            'Follow His life through excerpts from the Book of Luke, all the miracles, the teachings, and the passion.'
        }
      end
      media_payload do
        {
          'streamingUrls' => {
            'hls' => [{
              'url' => 'http://arc.gt/j67rz?apiSessionId=1234567890'
            }]
          }
        }
      end
    end
  end
end
