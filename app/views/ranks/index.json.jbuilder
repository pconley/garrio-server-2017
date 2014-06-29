json.array!(@ranks) do |rank|
  json.extract! rank, :id, :score, :user_id, :language_id
  json.url rank_url(rank, format: :json)
end
