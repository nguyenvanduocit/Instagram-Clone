json.array!(@hashtags) do |hashtag|
  json.extract! hashtag, :id
  json.url hashtag_url(hashtag, format: :json)
end
