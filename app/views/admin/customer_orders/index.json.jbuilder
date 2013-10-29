json.array!(@customer_orders) do |customer_order|
  json.extract! customer_order, :table_id, :order_total, :is_order_ready
  json.url customer_order_url(customer_order, format: :json)
end
