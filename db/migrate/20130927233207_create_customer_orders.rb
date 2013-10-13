class CreateCustomerOrders < ActiveRecord::Migration
  def change
    create_table :customer_orders do |t|
      t.integer :table_id
      t.boolean :is_order_ready
      t.boolean :is_order_paid_for

      t.timestamps
    end
  end
end
