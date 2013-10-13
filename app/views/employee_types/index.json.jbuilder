json.array!(@employee_types) do |employee_type|
  json.extract! employee_type, :type_name
  json.url employee_type_url(employee_type, format: :json)
end
