json.array!(@employee_tables) do |employee_table|
  json.extract! employee_table, :employee_id, :table_id, :assign_date
  json.url employee_table_url(employee_table, format: :json)
end
