class ProductsCart < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product
  belongs_to :order, optional: true

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }

  before_create :set_default_quantity

  def self.ransackable_associations(auth_object = nil)
    ["cart", "product", "order"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "id", "product_id", "quantity", "updated_at", "order_id"]
  end

  private

  def set_default_quantity
    self.quantity ||= 1
  end
end
