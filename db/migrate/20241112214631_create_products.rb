class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :product_name
      t.references :category, null: false, foreign_key: true
      t.boolean :availability
      t.decimal :price
      t.timestamps
    end
  end
end
