class CustomerOrder < ActiveRecord::Base
  belongs_to :table
  has_many :customer_order_items
  
  validates_presence_of :table_id, :is_order_ready, :is_order_paid_for
end
