json.array!(@menu_items) do |menu_item|
  json.extract! menu_item, :item_name, :item_price, :menu_id, :is_menu_item_available
  json.url menu_item_url(menu_item, format: :json)
end
