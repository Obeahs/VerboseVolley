ActiveAdmin.register Product do
  remove_filter :image_attachment, :image_blob, :products_carts
  permit_params :product_name, :category_id, :availability, :price, :image, :description

  filter :category, as: :select, collection: Category.all.collect { |c| [c.category_name, c.id] }
  filter :availability
  filter :price
  filter :product_name

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :category, as: :select, collection: Category.all.collect { |c| [c.category_name, c.id] }
      f.input :availability
      f.input :price
      f.input :image, as: :file
      f.input :description
    end
    f.actions
  end

  index do
    selectable_column
    column :product_name
    column :category_name, sortable: 'categories.category_name' do |product|
      product.category.category_name  # Display the category name
    end
    column :availability
    column :price
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image.variant(resize_to_limit: [50, 50]))
      end
    end
    actions
  end

  # Show details page
  show do
    attributes_table do
      row :product_name
      row :category do |product|
        product.category.category_name  # Display the category name
      end
      row :availability
      row :price
      row :description
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image)
        else
          'No image available'
        end
      end
      row :created_at
      row :updated_at
    end
  end
end
