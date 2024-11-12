class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :customer_name
      t.string :email
      t.string :password
      t.string :phone_number

      t.timestamps
    end
  end
end
