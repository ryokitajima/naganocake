class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
  end
  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :customer_id, :amount, :image)
  end
end
