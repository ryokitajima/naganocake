class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
end
