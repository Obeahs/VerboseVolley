class AddAddressAndProvinceToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :address, :string unless column_exists?(:customers, :address)
    add_column :customers, :province_id, :integer unless column_exists?(:customers, :province_id)
  end
end
