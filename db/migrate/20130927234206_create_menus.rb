class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :menu_name
      t.float :start_time
      t.float :end_time

      t.timestamps
    end
  end
end
