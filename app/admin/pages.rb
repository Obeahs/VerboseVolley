ActiveAdmin.register Page do
  permit_params :name, :content

  form do |f|
    f.inputs do
      f.input :name
      f.input :content
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :content
    end
    active_admin_comments
  end
end
