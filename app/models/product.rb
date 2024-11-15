class Product < ApplicationRecord
  belongs_to :category
  has_many :products_carts
  has_many :carts, through: :products_carts
  has_one_attached :image

  validates :product_name, presence: true
  validates :price, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["category","carts"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["availability", "category_id", "created_at", "description", "id", "price", "product_name", "updated_at"]
  end
end
