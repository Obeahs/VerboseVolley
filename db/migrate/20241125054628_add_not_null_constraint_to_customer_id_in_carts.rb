class AddNotNullConstraintToCustomerIdInCarts < ActiveRecord::Migration[7.2]
  def change 
    change_column_null :carts, :customer_id, false 
  end
end
