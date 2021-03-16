require 'rails_helper'

RSpec.describe VisitorShortenedUrl, type: :model do
	describe 'associations' do
    it { is_expected.to belong_to(:short_url) }
  end

  describe 'validations' do
    it { validate_presence_of(:short_url) }
    it { validate_presence_of(:ip_address) }
  end
end
