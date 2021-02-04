# frozen_string_literal: true

class Content::Arclight < Content
  attr_writer :metadata_payload, :media_payload

  store_accessor :metadata,
                 :media_component_id,
                 :media_language_id,
                 :duration,
                 :picture_small_url,
                 :picture_medium_url,
                 :picture_large_url,
                 :hls_url
  validates :media_component_id,
            :media_language_id,
            :duration,
            :picture_small_url,
            :picture_medium_url,
            :picture_large_url,
            :hls_url,
            presence: true
  before_validation :set_content_attributes, :set_metadata_attributes

  def self.get(path, query: {}, retries: 3)
    response = HTTParty.get(
      "https://api.arclight.org/v2/#{path}",
      query: query.merge('apiKey' => ENV.fetch('ARCLIGHT_API_KEY'), 'platform' => 'android')
    )
    raise HTTParty::Error unless response.ok?

    response.to_h
  rescue HTTParty::Error
    raise if (retries -= 1).negative?

    sleep(10)
    retry
  end

  def self.languages
    @languages ||= get('media-languages', query: { 'limit' => 5000 })['_embedded']['mediaLanguages']
  end

  def metadata_payload
    @metadata_payload ||= Content::Arclight.get("media-components/#{media_component_id}")
  end

  def media_payload
    @media_payload ||= Content::Arclight.get("media-components/#{media_component_id}/languages/#{media_language_id}")
  end

  protected

  def set_content_attributes
    self.name = metadata_payload['title']
    self.description = metadata_payload['shortDescription']
    self.locale ||= self.class.languages.find do |language|
      language['languageId'].to_s == media_language_id
    end&.dig('bcp47')
  end

  def set_metadata_attributes
    set_duration
    set_picture_urls
    set_hls_url
  end

  def set_duration
    self.duration = metadata_payload['lengthInMilliseconds']
  end

  def set_picture_urls
    self.picture_large_url = metadata_payload['imageUrls']['mobileCinematicHigh']
    self.picture_medium_url = metadata_payload['imageUrls']['mobileCinematicLow']
    self.picture_small_url = metadata_payload['imageUrls']['mobileCinematicVeryLow'].presence || picture_medium_url
  end

  def set_hls_url
    self.hls_url = media_payload.dig('streamingUrls', 'hls')&.map { |hls| hls['url'] }&.first
  end
end
