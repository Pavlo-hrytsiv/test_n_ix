json.array!(@urls) do |url|
  json.extract! url, :id, :full_url, :short_url, :active
  json.url url_url(url, format: :json)
end
