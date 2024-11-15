class AddRecentlyUpdatedToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :recently_updated, :boolean
  end
end
