class CreateEmployeeTables < ActiveRecord::Migration
  def change
    create_table :employee_tables do |t|
      t.integer :employee_id
      t.integer :table_id
      t.datetime :assign_date

      t.timestamps
    end
  end
end
