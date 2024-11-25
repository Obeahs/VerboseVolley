# app/admin/products_carts.rb
ActiveAdmin.register ProductsCart do
  permit_params :product_id, :cart_id, :quantity

  config.per_page = 20 # Customize as needed

  index do
    selectable_column
    id_column
    column "User" do |products_cart|
      products_cart.cart.customer.email
    end
    column :cart
    column :product
    column :quantity
    actions
  end

  form do |f|
    f.inputs do
      f.input :cart
      f.input :product
      f.input :quantity
    end
    f.actions
  end

  collection_action :delete_all, method: :delete do
    ProductsCart.destroy_all
    redirect_to admin_products_carts_path, notice: 'All products have been removed.'
  end

  action_item :delete_all, only: :index do
    link_to 'Delete All Products', delete_all_admin_products_carts_path, method: :delete, data: { confirm: 'Are you sure you want to delete all products?' }
  end
end
