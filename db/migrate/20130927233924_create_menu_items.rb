class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :item_name
      t.decimal :item_price
      t.integer :menu_id

      t.timestamps
    end
  end
end
