# frozen_string_literal: true

class Cron::FetchArclightContentWorker
  include Sidekiq::Worker
  sidekiq_options queue: :low

  def perform
    media_components.each do |media_component|
      next unless media_component['contentType'] == 'video'

      find_or_create_content(
        media_component['mediaComponentId'],
        media_component['primaryLanguageId'].to_s
      )
    end
  end

  protected

  def find_or_create_content(media_component_id, media_language_id)
    Content::Arclight.find_by(
      "metadata->>'media_component_id' = ? AND metadata->>'media_language_id' = ?",
      media_component_id, media_language_id
    ) || Content::Arclight.create(media_component_id: media_component_id, media_language_id: media_language_id)
  end

  def media_components
    @media_components ||= Content::Arclight.get('media-components')['_embedded']['mediaComponents']
  end
end
