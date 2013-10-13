class MenuItem < ActiveRecord::Base
  belongs_to :customer_order_item
  belongs_to :menu
end
