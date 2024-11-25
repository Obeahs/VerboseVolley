class Cart < ApplicationRecord
  belongs_to :customer
  has_many :products_carts, dependent: :destroy
  has_many :products, through: :products_carts

  def add_product(product_id)
    if persisted?
      product_cart = products_carts.find_or_initialize_by(product_id: product_id)
      product_cart.quantity ||= 0
      product_cart.quantity += 1
      product_cart.save!
    else
      raise ActiveRecord::RecordNotSaved, "Cart must be saved before adding products"
    end
  end

  def remove_product(product_id)
    products_carts.where(product_id: product_id).destroy_all
  end

  def update_product(product_id, quantity)
    item = products_carts.find_by(product_id: product_id)
    item.update(quantity: quantity) if item
  end

  def total_price
    products_carts.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  def empty?
    products_carts.empty?
  end

  def delete_all_products
    products_carts.destroy_all
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "products", "products_carts"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "id_value", "total_price", "updated_at"]
  end
end
