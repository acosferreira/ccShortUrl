require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:visitor_shortened_urls).dependent(:destroy) }
  end

  describe 'validations' do
    it { validate_presence_of(:shortened_url) }
    it { validate_presence_of(:original_url) }
    it { validate_presence_of(:full_url) }
    it { validate_uniqueness_of(:full_url) }
  end

  describe 'before_validation' do
    context 'shorten url' do
      it 'creates a 5 character url' do
        short_url = ShortUrl.create(original_url: 'chitchats.com')
        expect(short_url.shortened_url).to_not be_nil
        expect(short_url.shortened_url.length).to eq 5
      end
    end
  end

  describe 'return full url' do
    let(:url) { ShortUrl.create(original_url: 'chitchats.com') }
    it 'returns a formatted url' do
      expect(url.full_url).to eq 'http://chitchats.com'
    end
  end

  describe 'return scheme url' do
    let(:url) { ShortUrl.create(original_url: 'http://www.chitchats.com') }
    it 'returns a formatted url' do
      expect(url.full_url).to eq 'http://www.chitchats.com'
    end
  end

  describe 'return invalid url' do
    let(:url) { ShortUrl.create(original_url: 'chit chats') }
    it 'returns a formatted url' do
      expect(url.errors.full_messages).to eq ['invalid url format', 'Shortened url can\'t be blank']
    end
  end
end
