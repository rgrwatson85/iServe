class Table < ActiveRecord::Base
  has_many :customer_orders

  has_many :employee_tables
  has_many :employees, through: :employee_tables

end
