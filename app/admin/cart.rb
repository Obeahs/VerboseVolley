# app/admin/carts.rb
ActiveAdmin.register Cart do
  permit_params :customer_id

  index do
    selectable_column
    id_column
    column :customer
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :customer
      row :created_at
      row :updated_at
    end

    panel "Products in Cart" do
      table_for cart.products_carts do
        column "Product" do |item|
          item.product.product_name
        end
        column :quantity
        column "Price per Item" do |item|
          number_to_currency(item.product.price)
        end
        column "Total Price" do |item|
          number_to_currency(item.quantity * item.product.price)
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :customer
    end
    f.actions
  end
end
