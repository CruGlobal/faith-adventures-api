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
  before_validation :set_attributes, :set_picture_urls, :set_hls_url

  def metadata_payload
    return @metadata_payload if @metadata_payload

    response = HTTParty.get(
      "http://api.arclight.org/v2/media-components/#{media_component_id}",
      query: { 'apiKey' => ENV.fetch('ARCLIGHT_API_KEY') },
      headers: { 'Accept-Language' => 'en-US' }
    )

    self.metadata_payload = response.to_h if response.success?
  end

  def media_payload
    return @media_payload if @media_payload

    response = HTTParty.get(
      "http://api.arclight.org/v2/media-components/#{media_component_id}/languages/#{media_language_id}",
      query: { 'apiKey' => ENV.fetch('ARCLIGHT_API_KEY'), 'platform' => 'android' }
    )
    self.media_payload = response.to_h if response.success?
  end

  protected

  def set_attributes
    self.name = metadata_payload['title']
    self.description = metadata_payload['shortDescription']
    self.duration = metadata_payload['lengthInMilliseconds']
  end

  def set_picture_urls
    self.picture_small_url = metadata_payload['imageUrls']['mobileCinematicVeryLow']
    self.picture_medium_url = metadata_payload['imageUrls']['mobileCinematicLow']
    self.picture_large_url = metadata_payload['imageUrls']['mobileCinematicHigh']
  end

  def set_hls_url
    self.hls_url = media_payload['streamingUrls']['hls'].map { |hls| hls['url'] }[0]&.gsub('http://', 'https://')
  end
end
