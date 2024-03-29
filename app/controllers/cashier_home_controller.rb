class CashierHomeController < ApplicationController
  before_filter :is_authorized

  TAX_RATE = ApplicationController::TAX_RATE

  def index

  end

  def calculatetotal

    receipt = ''
    total = 0.0

    if (!params[:order_id])
      #mark all orders as having been paid
      @table = Table.find(params[:table_id])
      @orders = @table.customer_orders.where(:is_order_paid_for => false)
      @orders.each do |order|

        #get all order items price
        order.customer_order_items.each do |item|
          item = MenuItem.find(item.menu_item_id)
          total += item.item_price
          receipt << "<tr><td> #{item.item_name} </td>"
          receipt << "<td> #{ActionController::Base.helpers.number_to_currency(item.item_price, :precision => 2)} </td>"
        end
      end
      session[:table_id] = @table.id
    else
      #mark specific order as having been paid
      order = CustomerOrder.find(params[:order_id])

      #get all order items price
      order.customer_order_items.each do |item|
        item = MenuItem.find(item.menu_item_id)
        total += item.item_price
        receipt << "<tr><td> #{item.item_name} </td>"
        receipt << "<td> #{ActionController::Base.helpers.number_to_currency(item.item_price, :precision => 2)} </td>"
      end

      session[:table_id] = order.table_id
    end

    receipt << "<tr><td></td><td>SUBTOTAL</td><td>#{ActionController::Base.helpers.number_to_currency(total, :precision => 2)}</td>"
    receipt << "<tr><td></td><td>TAX</td><td>#{ActionController::Base.helpers.number_to_currency(total * TAX_RATE, :precision => 2)}</td>"
    receipt << "<tr><td></td><td>TOTAL</td><td>#{ActionController::Base.helpers.number_to_currency(total + total * TAX_RATE, :precision => 2)}</td>"
    render :text => receipt.html_safe
  end

  def processpayment

    total = 0.0

    if (!params[:order_id])
      #mark all orders as having been paid
      @table = Table.find(params[:table_id])
      @orders = @table.customer_orders.where(:is_order_paid_for => false)
      @orders.each do |order|

        order.is_order_ready    = true
        order.is_order_paid_for = true
        order.save!

      end
      session[:table_id] = @table.id
    else
      #mark specific order as having been paid
      order = CustomerOrder.find(params[:order_id])
      order.is_order_ready    = true
      order.is_order_paid_for = true
      order.save!
      session[:table_id] = order.table_id
    end

    render :text => 'Transaction completed'

  end



  private

  def is_authorized
    if ![1,3].include?(current_user.user_type_id)
      flash[:error] = 'Not authorized to view this resource.'
      redirect_to :back
    end
  end

end
