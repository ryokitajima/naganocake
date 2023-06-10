class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    
  end
  
  def index
    @orders = Order.page(params[:page]).per(10)
    
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method]
    @order.postage = params[:order][:postage]
    @order.payment = params[:order][:payment]
    if @order.save
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        order_item = OrderItem.new(order_id: @order.id)
        order_item.tax_included_price = cart_item.item.add_tax_price.to_i
        order_item.amount = cart_item.amount
        order_item.item_id = cart_item.item_id
        order_item.save
      end
    @cart_items.destroy_all
    redirect_to complete_orders_path
    else
    render "new"
    end
  end

  def confirm
    @cart_items = CartItem.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal.to_i }
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @order.payment_method = params[:order][:payment_method]
    @order.payment = @cart_items.inject(0) { |sum, item| sum + item.subtotal.to_i } + @order.postage.to_i
  end

  def complete
  end


  private
  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :payment)
  end
  def order_item_params
  params.require(:order_item).permit(:order_id, :item_id, :amount, :tax_imcluded_price)
  end
end
