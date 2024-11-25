class RemoveCustomerNameFromCustomers < ActiveRecord::Migration[7.2]
  def change
    remove_column :customers, :customer_name, :string
  end
end
