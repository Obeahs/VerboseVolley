# app/admin/customers.rb
ActiveAdmin.register Customer do
  permit_params :customer_name, :email, :password, :phone_number, :address, :province_id

  filter :customer_name
  filter :email
  filter :phone_number
  filter :province

  form do |f|
    f.inputs do
      f.input :customer_name
      f.input :email
      f.input :password
      f.input :phone_number
      f.input :address
      f.input :province
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :customer_name
    column :email
    column :phone_number
    column :address
    column :province
    actions
  end

  show do
    attributes_table do
      row :customer_name
      row :email
      row :phone_number
      row :address
      row :province
    end
    active_admin_comments
  end
end
