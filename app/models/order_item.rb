class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  def subtotal
    tax_included_price * amount
  end
  
end
