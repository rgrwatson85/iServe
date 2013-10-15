json.array!(@users) do |user|
  json.extract! user, :first_name, :last_name, :user_type_id
  json.url user_url(user, format: :json)
end
