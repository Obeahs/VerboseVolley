class Product < ApplicationRecord
  belongs_to :category  
  has_one_attached :image
  has_many :products_carts
  has_many :carts, through: :products_carts

  validates :product_name, :category, :price, :availability, :description, presence: true

  # Ransackable associations
  def self.ransackable_associations(auth_object = nil)
    ["category", "carts"] 
  end

  # Ransackable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["availability", "created_at", "description", "id", "price", "product_name", "updated_at"]
  end
end
