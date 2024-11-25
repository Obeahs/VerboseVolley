class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :province
  belongs_to :cart, optional: true
  has_many :products_carts, dependent: :destroy
  has_many :products, through: :products_carts

  attr_accessor :credit_card_number, :expiration_date, :cvv

  validates :province_id, presence: true
  validates :total_price, presence: true

  enum status: { pending: 0, paid: 1, shipped: 2 }

  def self.ransackable_associations(auth_object = nil)
    ["cart", "customer", "products", "province"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "cart_id", "created_at", "customer_id", "id", "province_id", "status", "total_price", "updated_at"]
  end

  def add_cart_items(cart)
    cart.products_carts.each do |cart_item|
      products_carts.create!(
        product: cart_item.product,
        quantity: cart_item.quantity,
        cart_id: cart_item.cart_id,
        order: self
      )
    end
  end
end
