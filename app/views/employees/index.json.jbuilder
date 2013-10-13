json.array!(@employees) do |employee|
  json.extract! employee, :first_name, :last_name, :employee_type_id
  json.url employee_url(employee, format: :json)
end
