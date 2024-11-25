ActiveAdmin.register Customer do
  permit_params :customer_name, :email, :password, :phone_number, :address, :province_id

  filter :customer_name
  filter :email
  filter :phone_number
  filter :address
  filter :province

  form do |f|
    f.inputs do
      f.input :customer_name, label: 'Customer'
      f.input :email
      f.input :password
      f.input :phone_number
      f.input :address
      f.input :province, as: :select, collection: Province.all.map { |p| [p.name, p.id] }
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column 'Customer', :customer_name
    column 'Address', :address
    column 'Province', :province
    column :email
    column :phone_number
    actions
  end

  show do
    attributes_table do
      row 'Customer', &:customer_name
      row 'Address', &:address
      row 'Province', &:province
      row :email
      row :phone_number
    end
    active_admin_comments
  end
end
