class CustomerOrderItem < ActiveRecord::Base
  belongs_to :customer_order
  has_many :menu_items
  
  validates_presence_of :customer_order_id, :menu_item_id, :is_menu_item_ready, :waitstaff_note
end
