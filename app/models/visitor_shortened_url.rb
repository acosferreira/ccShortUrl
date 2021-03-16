# frozen_string_literal: false

class VisitorShortenedUrl < ApplicationRecord
  belongs_to :short_url
  validates_presence_of :ip_request
end
