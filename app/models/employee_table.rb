class EmployeeTable < ActiveRecord::Base
  belongs_to :employee
  belongs_to :table
end
