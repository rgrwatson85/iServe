# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

EmployeeType.create([
    {:type_name => 'Manager'},
    {:type_name => 'Waiter'},
    {:type_name => 'Cashier'},
    {:type_name => 'Cook'},
])

Employee.create([
    {:first_name => 'Morgan', :last_name => 'Watson', :employee_type_id=> 1},
    {:first_name => 'James', :last_name => 'Williams', :employee_type_id=> 2},
    {:first_name => 'Betty', :last_name => 'Draper', :employee_type_id=> 2},
    {:first_name => 'Dorothy', :last_name => 'Whitney', :employee_type_id=> 2},
    {:first_name => 'John', :last_name => 'Higgins', :employee_type_id=> 3},
    {:first_name => 'Adam', :last_name => 'Holloway', :employee_type_id=> 3},
    {:first_name => 'Miguel', :last_name => 'Buckner', :employee_type_id=> 4},
    {:first_name => 'Mary', :last_name => 'Fischer', :employee_type_id=> 4},
    {:first_name => 'John', :last_name => 'Gilbert', :employee_type_id=> 4},
])

tables = Table.create([
    {:table_name => 'Table A'},
    {:table_name => 'Table B'},
    {:table_name => 'Table C'},
    {:table_name => 'Table D'},
    {:table_name => 'Table E'},
    {:table_name => 'Table F'},
    {:table_name => 'Table G'},
    {:table_name => 'Table H'},
    {:table_name => 'Table I'},
    {:table_name => 'Table J'},
])

EmployeeTable.create([
    {:employee_id => 2, :table_id => 1, :assign_date => Date.today},
    {:employee_id => 2, :table_id => 2, :assign_date => Date.today},
    {:employee_id => 2, :table_id => 3, :assign_date => Date.today},

    {:employee_id => 3, :table_id => 4, :assign_date => Date.today},
    {:employee_id => 3, :table_id => 5, :assign_date => Date.today},
    {:employee_id => 3, :table_id => 6, :assign_date => Date.today},

    {:employee_id => 4, :table_id => 7, :assign_date => Date.today},
    {:employee_id => 4, :table_id => 8, :assign_date => Date.today},
    {:employee_id => 4, :table_id => 9, :assign_date => Date.today},

    #assign multiple waiters to one table
    {:employee_id => 2, :table_id => 10, :assign_date => Date.today},
    {:employee_id => 3, :table_id => 10, :assign_date => Date.today},
    {:employee_id => 4, :table_id => 10, :assign_date => Date.today},
])

Menu.create([
    {:menu_name => 'Breakfast', :start_time => 25200, :end_time => 39600},
    {:menu_name => 'Lunch',     :start_time => 39600, :end_time => 57600},
    {:menu_name => 'Dinner',    :start_time => 57600, :end_time => 79200},

])

MenuItem.create([
    {:item_name => 'Scrambled Eggs',      :item_price => 2,  :menu_id => 1},
    {:item_name => 'Bacon',               :item_price => 3,  :menu_id => 1},
    {:item_name => 'Biscuits',            :item_price => 3,  :menu_id => 1},

    {:item_name => 'BLT Sandwhich',       :item_price => 5,  :menu_id => 2},
    {:item_name => 'Chicken Soup',        :item_price => 7,  :menu_id => 2},
    {:item_name => 'Pho',                 :item_price => 6,  :menu_id => 2},

    {:item_name => 'Filet Mignon',        :item_price => 25, :menu_id => 3},
    {:item_name => 'Chicken Fried Steak', :item_price => 12, :menu_id => 3},
    {:item_name => 'Cesar Salad',         :item_price => 9,  :menu_id => 3},
    {:item_name => 'Bun Thit Nuong',  :item_price => 6,  :menu_id => 3}
])

tables.each do |table|
  num_cust = rand(4)+1
  if table.id == 10
    num_cust = 10
  end
  (1..num_cust).each do |customer|
    customer_order = CustomerOrder.create(:table_id => table.id, :is_order_ready => false, :is_order_paid_for => false)
    CustomerOrderItem.create(:customer_order_id => customer_order.id, :menu_item_id => (4..10).to_a.sample, :is_menu_item_ready => false, :waitstaff_note => nil)
    if customer==3
      CustomerOrderItem.create(:customer_order_id => customer_order.id, :menu_item_id => (4..10).to_a.sample, :is_menu_item_ready => false, :waitstaff_note => nil)
    end
  end
end