class CreateUserTables < ActiveRecord::Migration
  def change
    create_table :user_tables do |t|
      t.integer :user_id
      t.integer :table_id
      t.datetime :assign_date

      t.timestamps
    end
  end
end
