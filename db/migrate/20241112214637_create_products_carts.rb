class CreateProductsCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :products_carts do |t|
      t.references :product, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
