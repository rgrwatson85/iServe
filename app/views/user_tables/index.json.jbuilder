json.array!(@user_tables) do |user_table|
  json.extract! user_table, :user_id, :table_id, :assign_date
  json.url user_table_url(user_table, format: :json)
end
