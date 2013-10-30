class CustomerOrder < ActiveRecord::Base
  belongs_to :table
  has_many :customer_order_items
  
  validates_presence_of :table_id
  validates_inclusion_of :is_order_ready, :in => [true, false]
  validates_inclusion_of :is_order_paid_for, :in => [true, false]
end
