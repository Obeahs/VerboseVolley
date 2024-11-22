class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :cart
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :province_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "customer_id", "id", "updated_at"]
  end

  def create_order_items(cart_items)
    cart_items.each do |cart_item|
      order_items.create(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
    end
  end
end
