class Product < ApplicationRecord
  belongs_to :category

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["availability", "category_id", "created_at", "id", "price", "product_name", "updated_at"]
  end

end
