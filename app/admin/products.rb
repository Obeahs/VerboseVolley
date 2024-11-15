ActiveAdmin.register Product do
  remove_filter :image_attachment, :image_blob
  permit_params :product_name, :category_id, :availability, :price, :description, :image

  filter :product_name
  filter :category
  filter :availability
  filter :price
  filter :description

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :category
      f.input :availability
      f.input :price
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :product_name
      row :category
      row :availability
      row :price
      row :description
      row :image do |product|
        image_tag url_for(product.image) if product.image.attached?
      end
    end
    active_admin_comments
  end
end
