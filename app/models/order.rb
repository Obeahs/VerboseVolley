class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :cart

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "customer_id", "id", "updated_at"]
  end

end
