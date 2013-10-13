class Employee < ActiveRecord::Base
  has_one :employee_type
  has_many :employee_tables
  has_many :tables, through: :employee_tables
end
