class AddQuantityToProductsCarts < ActiveRecord::Migration[7.2]
  def change
    add_column :products_carts, :quantity, :integer
  end
end
