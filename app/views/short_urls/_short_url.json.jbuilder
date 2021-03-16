json.extract! short_url, :id, :original_url, :shortened_url, :full_url, :created_at, :updated_at
json.url short_url_url(short_url, format: :json)
