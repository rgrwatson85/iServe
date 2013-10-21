class WaitStaffHomeController < ApplicationController

  before_filter :is_authorized_to_view_table, :only => [:vieworders]
  before_filter :is_authorized, :except => [:vieworders]

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
      @percent_done = ActionController::Base.helpers.number_to_percentage( (items_complete/items_total) * 100, :precision => 1 )
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
    @order.destroy!
    render :json => {'success' => true}
  end

  def editorder

    @order = CustomerOrder.find(params[:id])

    if (params[:update] && params[:update] == 'true')
      #check that there are items in the order /
      #error if not - tell user to delete the order entirely from the view order view
      order = params[:order]
      if !order
        render :text => 'You cant have an order with no items. Try deleting the entire order...'
      else
        @order.is_order_ready = true
        order.each do |key, value|
          item = value['menu_item']
          if @order.is_order_ready
            @order.is_order_ready = value['order_item_id'] ? true : false
            @order.save!
          end

          #catches new items added to order
          order_item_id         = value['order_item_id'] || CustomerOrderItem.create(:customer_order_id => @order.id).id
          note                  = value['menu_item_note']
          marked_for_deletion   = value['delete'] == 'true' ? true : false

          order_item = CustomerOrderItem.find(order_item_id)

          #if not marked for deletion
          if !marked_for_deletion
            #if the item name or the note for the item has changed, mark the item as not complete
            if order_item.menu_item_id != MenuItem.find_by_item_name(item).id || order_item.waitstaff_note != note
              order_item.is_menu_item_ready = false
              @order.is_order_ready = false
              @order.save!
            end

            order_item.menu_item_id = MenuItem.find_by_item_name(item).id
            order_item.waitstaff_note = note
            order_item.save!
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

  private

  def is_authorized
    utid = current_user.user_type_id
    if utid > 2
      flash[:error] = 'Not authorized to view this resource.'
      redirect_to :back
    end
  end

  def is_authorized_to_view_table
    utid = current_user.user_type_id
    if utid > 3
      render :text => 'Not authorized to view this resource.'
    end
  end

end
