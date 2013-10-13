json.array!(@menus) do |menu|
  json.extract! menu, :menu_name, :start_time, :end_time
  json.url menu_url(menu, format: :json)
end
