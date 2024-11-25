class AddAddressAndProvinceToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :address, :string
    add_column :customers, :province_id, :integer
  end
end
