class CustomerOrder < ActiveRecord::Base
  belongs_to :table
  has_many :customer_order_items
end
