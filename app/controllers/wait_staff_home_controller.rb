class WaitStaffHomeController < ApplicationController

  def index

  end

  def vieworders
    if params[:table_id] || session[:table_id]
      @table = Table.find(params[:table_id] || session[:table_id])
    else
      @table = Table.first
    end

    @orders = @table.customer_orders.where(:is_order_paid_for => false)

    @total = 0.0
    items_complete = 0.0
    items_total = 0.0

    @orders.each do |order|
      order.customer_order_items.each do |item|
        items_total += 1
        if item.is_menu_item_ready
          items_complete += 1
        end
        item_price = MenuItem.find(item.menu_item_id).item_price
        @total += item_price
      end
    end

    if items_total > 0
      @percent_done = ((items_complete/items_total) * 100).to_s << '%'
    else
      @percent_done = '0.0%'
    end

  end

  def neworder
    @table = Table.find(params[:table_id])
    session[:table_id] = @table.id
  end

  def saveorder

    orders = params[:orders]

    order = CustomerOrder.new()
    order.table_id = session[:table_id]
    order.is_order_ready = false
    order.is_order_paid_for = false
    order.save
    order_id = order.id

    orders.each do |key, value|
      item = value['menu_item']
      note = value['menu_item_note']

      order_item = CustomerOrderItem.new()
      order_item.customer_order_id = order_id
      order_item.menu_item_id = MenuItem.find_by_item_name(item).id
      order_item.is_menu_item_ready = false
      order_item.waitstaff_note = note
      order_item.save

    end

    render :text => 'Order Submitted'

  end

  def deleteorder
    @order = CustomerOrder.find(params[:id])
    @order.destroy
    render :json => {'success' => true}
  end

  def editorder

    @order = CustomerOrder.find(params[:id])

    if (params[:update])
      #check that there are items in the order / error if not - tell user to delete the order entirely from the view order view
      order = params[:order]
      if !order
        render :text => 'You cant have an order with no items. Try deleting the entire order...'
      else

        order.each do |key, value|
          item = value['menu_item']
          order_item_id = value['order_item_id'] || CustomerOrderItem.create().id #catches new items added to order
          note = value['menu_item_note']
          marked_for_deletion = value['delete'] || false

          order_item = CustomerOrderItem.find(order_item_id)

          #if not marked for deletion
          if !marked_for_deletion
            #if the item name or the note for the item has changed, mark the item as not complete
            if order_item.menu_item_id != MenuItem.find_by_item_name(item).id || order_item.waitstaff_note != note
              order_item.is_menu_item_ready = false
            end

            order_item.menu_item_id = MenuItem.find_by_item_name(item).id
            order_item.waitstaff_note = note
            order_item.save
          else
            order_item.destroy!
          end



        end

        render :text => 'Order successfully updated.'
      end
    end

    #set to return user to the correct table
    session[:table_id] = @order.table_id

  end

end
