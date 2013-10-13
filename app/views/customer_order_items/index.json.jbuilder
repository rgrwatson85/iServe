json.array!(@customer_order_items) do |customer_order_item|
  json.extract! customer_order_item, :customer_order_id, :menu_item_id, :is_menu_item_ready, :customer_note, :waitstaff_note, :kitchenstaff_note
  json.url customer_order_item_url(customer_order_item, format: :json)
end
