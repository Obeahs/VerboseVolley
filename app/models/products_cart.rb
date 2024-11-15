class ProductsCart < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :product_id, presence: true
  validates :cart_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "id", "product_id", "updated_at"]
  end
end
