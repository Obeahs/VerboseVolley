class ProductsCart < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }

  before_create :set_default_quantity

  private

  def set_default_quantity
    self.quantity ||= 1
  end
end
