class CustomerOrderItem < ActiveRecord::Base
  belongs_to :customer_order
  has_many :menu_items
end
