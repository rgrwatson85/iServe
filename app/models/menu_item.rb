class MenuItem < ActiveRecord::Base
  belongs_to :customer_order_item
  belongs_to :menu
  
  validates_presence_of :item_name, :item_price, :menu_id
  validates_numericality_of :item_price, :greater_than => 0
end
