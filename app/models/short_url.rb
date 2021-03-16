# frozen_string_literal: false

class ShortUrl < ApplicationRecord
  has_many :visitor_shortened_urls, dependent: :destroy

  validates :original_url, :shortened_url, presence: true
  validates :full_url, uniqueness: true

  before_validation :generate_tiny

  private

  def generate_tiny
    if url_valid?
        handle_full_url
        self.shortened_url = Digest::MD5.hexdigest(full_url)[0..4]
    else
      errors.add(:base, 'invalid url format')
    end
  end

  def handle_full_url
    url = URI.parse(original_url)
    self.full_url = url.scheme.present? ? original_url : "http://#{url.path}"
  end

  def url_valid?
    url = URI.parse(original_url)
    url.kind_of?(URI::Generic)
  rescue URI::InvalidURIError
    errors.add(:base, 'invalid url format')
    false
  end
end
