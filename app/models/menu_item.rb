class MenuItem < ActiveRecord::Base
  has_many :customer_order_items
  has_many :customer_orders, through: :customer_order_items
  belongs_to :menu
  
  validates_presence_of :item_name, :item_price, :menu_id
  validates_numericality_of :item_price, :greater_than => 0
end
