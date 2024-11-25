class AddOrderIdToProductsCarts < ActiveRecord::Migration[7.2]
  def change
    add_reference :products_carts, :order, foreign_key: true
  end
end
