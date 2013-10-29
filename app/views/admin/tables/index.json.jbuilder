json.array!(@tables) do |table|
  json.extract! table, :table_name, :balance_due
  json.url table_url(table, format: :json)
end
