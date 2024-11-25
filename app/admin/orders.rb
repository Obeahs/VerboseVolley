ActiveAdmin.register Order do
  permit_params :customer_id, :address, :province_id, :total_price, :status

  index do
    selectable_column
    id_column
    column :customer
    column :address
    column :province
    column :total_price
    column :status
    column :created_at
    actions
  end

  filter :customer
  filter :address
  filter :province
  filter :total_price
  filter :status
  filter :created_at

  form do |f|
    f.inputs do
      f.input :customer
      f.input :address
      f.input :province
      f.input :total_price
      f.input :status, as: :select, collection: Order.statuses.keys
    end
    f.actions
  end

  show do
    attributes_table do
      row :customer
      row :address
      row :province
      row :total_price
      row :status
      row :created_at
      row :updated_at
    end

    panel "Products in Order" do
      table_for order.cart.products_carts do
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
end
