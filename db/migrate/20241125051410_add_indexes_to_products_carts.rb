class AddIndexesToProductsCarts < ActiveRecord::Migration[7.2]
  def change
    # Index on customer_id (to optimize queries filtering by customer)
    add_index :carts, :customer_id

    # Index on created_at (for efficient ordering by creation date)
    add_index :carts, :created_at

    # Composite index on customer_id and created_at for frequent queries on both
    add_index :carts, [:customer_id, :created_at]

    # Optional: Index on product_id in the carts table if carts belong to products (if relevant)
    # add_index :carts, :product_id
  end
end
