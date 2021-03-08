# frozen_string_literal: true

FirebaseIdToken.configure do |config|
  config.project_ids =
    if ENV['FIREBASE_PROJECT_ID']
      [ENV['FIREBASE_PROJECT_ID']]
    else
      %w[
        voke-6ee71
        faith-adventures
      ]
    end
end
