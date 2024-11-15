class Cart < ApplicationRecord
    has_many :products_carts
    has_many :products, through: :products_carts
    has_one :order
  
    validates :total_price, presence: true
    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "total_price", "updated_at"]
      end
    
  end
  