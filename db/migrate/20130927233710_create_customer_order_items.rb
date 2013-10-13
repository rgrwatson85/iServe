class CreateCustomerOrderItems < ActiveRecord::Migration
  def change
    create_table :customer_order_items do |t|
      t.integer :customer_order_id
      t.integer :menu_item_id
      t.boolean :is_menu_item_ready
      t.text :waitstaff_note

      t.timestamps
    end
  end
end
