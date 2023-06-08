class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  has_many :order_items, dependent: :destroy
  has_many :items, dependent: :destroy
  

end

