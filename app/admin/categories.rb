ActiveAdmin.register Category do
  permit_params :category_name

  form do |f|
    f.inputs do
      f.input :category_name
    end
    f.actions
  end
end
