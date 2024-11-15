ActiveAdmin.register Customer do
  permit_params :customer_name, :email, :password, :phone_number

  form do |f|
    f.inputs do
      f.input :customer_name
      f.input :email
      f.input :password
      f.input :phone_number
    end
    f.actions
  end

  show do
    attributes_table do
      row :customer_name
      row :email
      row :phone_number
    end
    active_admin_comments
  end
end
