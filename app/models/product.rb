class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_many :products_carts
  has_many :carts, through: :products_carts

  validates :product_name, :category, :price, :availability, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  validates_inclusion_of :availability, in: [true, false], message: "must be either available or unavailable"

  def self.ransackable_associations(auth_object = nil)
    ["category", "carts"] 
  end

  def self.ransackable_attributes(auth_object = nil)
    super + ["category_id", "availability", "created_at", "description", "id", "price", "product_name", "updated_at", "recently_updated"]
  end

  before_update :mark_as_recently_updated

  private

  def mark_as_recently_updated
    self.recently_updated = true
  end
end
