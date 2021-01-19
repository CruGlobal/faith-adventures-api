# frozen_string_literal: true

class Cron::FetchFirebaseCertificatesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :low

  def perform
    FirebaseIdToken::Certificates.request!
  end
end
