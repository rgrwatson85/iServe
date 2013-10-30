class CustomerOrderItem < ActiveRecord::Base
  belongs_to :customer_order
  has_one :menu_item
  
  validates_presence_of :customer_order_id, :menu_item_id
  validates_inclusion_of :is_menu_item_ready, :in => [true, false]
  validates_presence_of :waitstaff_note, allow_nil: true
end
