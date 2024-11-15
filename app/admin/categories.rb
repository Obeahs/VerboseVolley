ActiveAdmin.register Category do
  permit_params :category_name

  # Custom action for deleting all categories
  action_item :delete_all, only: :index do
    link_to 'Delete All', delete_all_admin_categories_path, method: :delete, data: { confirm: 'Are you sure you want to delete all categories?' }
  end

  collection_action :delete_all, method: :delete do
    Category.destroy_all
    redirect_to admin_categories_path, notice: 'All categories have been deleted.'
  end

  index do
    selectable_column
    column :category_name
    actions
  end

  form do |f|
    f.inputs do
      f.input :category_name
    end
    f.actions
  end
end
