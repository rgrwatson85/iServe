class CashierHomeController < ApplicationController
  def index
    @tables = Table.all

    if (params[:table_id] || session[:table_id])
      @table = Table.find(params[:table_id] || session[:table_id])
    else
      @table = Table.first
    end

    session[:table_id] = @table.id

    @total = 0.0

    orders = @table.customer_orders.where(:is_order_paid_for => false)

    orders.each do |order|
      order.customer_order_items.each do |item|
        item_price = MenuItem.find(item.menu_item_id).item_price
        @total += item_price
      end
    end

  end

  def processpayment

    if (!params[:order_id])
      #mark all orders as having been paid
      @table = Table.find(params[:table_id])
      @orders = @table.customer_orders.where(:is_order_paid_for => false)
      @orders.each do |order|
        order.is_order_ready    = true
        order.is_order_paid_for = true
        order.save!
      end
    else
      #mark specific order as having been paid
      order = CustomerOrder.find(params[:order_id])
      order.is_order_ready    = true
      order.is_order_paid_for = true
      order.save!
    end

    render :text => 'Payment processed.'

  end

end
