class CreateCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts do |t|
      t.decimal :total_price

      t.timestamps
    end
  end
end
