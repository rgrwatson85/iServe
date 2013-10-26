class KitchenStaffHomeController < ApplicationController
  before_filter :is_authorized

  def index
    @open_orders = CustomerOrder.where(:is_order_ready => false).order('table_id asc, id asc')
  end

  def getnote

    @order = CustomerOrder.find(params[:id])
    waiter_note = ''

    #get the notes for each item in the order
    @order.customer_order_items.each do |item|
      w_note = item.waitstaff_note
      item_name = MenuItem.find(item.menu_item_id).item_name

      if w_note != '' && w_note != nil
        waiter_note << '<b>' << item_name << '</b>: ' << w_note << '<br/>'
      end
    end

    if waiter_note == ''
      waiter_note = 'None'
    end

    #return json object of the notes
    render :text => waiter_note

  end

  def itemcomplete
    @item = CustomerOrderItem.find(params[:id])
    @item.is_menu_item_ready = !@item.is_menu_item_ready
    @item.save

    @order = CustomerOrder.find(@item.customer_order_id)

    #iterate through order items and check ready status
    @order.is_order_ready = true
    @order.customer_order_items.each do |item|
      #if any item is not ready then the order is not ready
      if item.is_menu_item_ready == false
        @order.is_order_ready = false
        break;
      end
    end

    @order.save

    render :text => 'Ready state changed'

  end



  private

  def is_authorized
    if ![1,4].include?(current_user.user_type_id)
      flash[:error] = 'Not authorized to view this resource.'
      redirect_to :back
    end
  end

end
