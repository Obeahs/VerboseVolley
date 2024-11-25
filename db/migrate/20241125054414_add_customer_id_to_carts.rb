class AddCustomerIdToCarts < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:carts, :customer_id)
      add_reference :carts, :customer, foreign_key: true
    end
  end
end
