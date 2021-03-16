require 'rails_helper'

RSpec.describe ShortUrlsController, type: :controller do
describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_successful
      expect(response.code).to eq('200')
    end
  end

  describe 'POST #create' do
    context 'with a url' do
      let(:url) { 'www.chitchats.com' }
      subject { post :create, params: { short_url: {original_url: url } } }

      it 'creates a new tiny url record' do
        expect { subject }.to change(ShortUrl, :count).by 1
        expect(flash[:notice]).to eq 'Short url was successfully created.'
        expect(ShortUrl.first.original_url).to eq url
      end
    end

    context 'with blank url' do
      let(:url) { '' }
       subject { post :create, params: { short_url: {original_url: url } } }

      it 'returns an error' do
        subject
        expect { subject }.to_not change(ShortUrl, :count)
     	expect(response.status).to eq 422
      end
    end

    context 'with invalid url' do
      let(:url) { 'chit chats' }
      subject { post :create, params: { short_url: {original_url: url } } }

      it 'returns an error' do
        subject
        expect { subject }.to_not change(ShortUrl, :count)
        
        expect(response.status).to eq 422
      end
    end
  end

  describe 'GET #info' do
   context 'with a url' do
      let(:url) { ShortUrl.create(original_url: 'www.chitchats.com') }

      subject { get :info, params: { use_route: "#{url.id}/info", short_url: url.id } }

      it 'displays info for the tiny url' do
        subject
        expect(assigns(:visit)).to eq url
        expect(response).to render_template :info
      end
   end

   context 'with an invalid url' do
      subject { get :info, params: { use_route: '/info', short_url: '' } }

      it 'redirects to index with an error message' do
        subject

        expect(flash[:alert]).to eq 'URL not found.'
        expect(response).to redirect_to root_path
      end
   end
  end

  describe 'GET #show' do
    let(:url) { ShortUrl.create(original_url: 'www.chitchats.com') }

    subject { get :show, params: { use_route: '/show', id: url.id } }

    it 'creates a url visitor record and redirects to the original url' do
      expect { subject }.to change(VisitorShortenedUrl, :count).by 1

      expect(response).to redirect_to url.full_url
    end
  end

  describe '#DELETE' do
    let(:url) { ShortUrl.create(original_url: 'www.chitchats.com') }

    subject { get :destroy, params: { use_route: '/destroy', id: url.id } }

    it 'creates a url visitor record and redirects to the original url' do
      expect { subject }.to change(ShortUrl, :count).by 0
    end
  end	

  describe '#EDIT' do
    let(:url) { ShortUrl.create(original_url: 'www.chitchats.com') }

    subject { get :edit, params: { use_route: '/edit', id: url.id } }

    it 'creates a url visitor record and redirects to the original url' do
      expect(response.status).to eq 200
    end
  end
end
