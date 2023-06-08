class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    @cart_items = CartItem.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal.to_i } + 800
    
  end

  def confirm
    @cart_items = CartItem.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal.to_i } + 800
    @order.payment_method = params[:order][:payment_method]
    @order.payment = params[:order][:payment]
  end

  private
  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :payment)
  end
end
