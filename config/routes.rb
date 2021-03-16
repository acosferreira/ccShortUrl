Rails.application.routes.draw do
	resources :short_urls

  get ':short_url/info', to: 'short_urls#info', param: :url, as: :info
  root to: 'short_urls#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
