ActiveAdmin.register Product do
  remove_filter :image_attachment, :image_blob, :products_carts
  permit_params :product_name, :category_id, :availability, :price, :image, :description

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :category, as: :select, collection: Category.all.collect { |c| [c.category_name, c.id] }  # Use category_name instead of name
      f.input :availability
      f.input :price
      f.input :image, as: :file
      f.input :description
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :product_name
    column :category
    column :availability
    column :price
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image.variant(resize_to_limit: [50, 50]))
      end
    end
    actions
  end
end
