json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :admin, :password_digest, :language_id, :remember_me
  json.url user_url(user, format: :json)
end
