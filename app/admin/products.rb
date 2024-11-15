ActiveAdmin.register Product do
  permit_params :product_name, :category_id, :availability, :price, :image, :description, :on_sale, :new_arrival, :recently_updated

  remove_filter :image_attachment, :image_blob, :products_carts
  
  filter :category, as: :select, collection: Category.all.collect { |c| [c.category_name, c.id] }
  filter :availability, as: :select, collection: [['Available', true], ['Unavailable', false]]
  filter :price
  filter :product_name
  filter :on_sale, as: :select, collection: [['On Sale', true], ['Not On Sale', false]]
  filter :new_arrival, as: :select, collection: [['New Arrival', true], ['Not New Arrival', false]]
  filter :recently_updated, as: :select, collection: [['Recently Updated', true], ['Not Recently Updated', false]]

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :category, as: :select, collection: Category.all.collect { |c| [c.category_name, c.id] }
      f.input :availability, as: :select, collection: [['Available', true], ['Unavailable', false]]
      f.input :price
      f.input :image, as: :file
      f.input :description
      f.input :on_sale, label: "On Sale"
      f.input :new_arrival, label: "New Arrival"
      f.input :recently_updated, label: "Recently Updated"
    end
    f.actions
  end

  index do
    selectable_column
    column :product_name
    column :category_name, sortable: 'categories.category_name' do |product|
      product.category.category_name
    end
    column :availability
    column :price
    column :on_sale
    column :new_arrival
    column :recently_updated
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image.variant(resize_to_limit: [50, 50]))
      end
    end
    actions
  end

  show do
    attributes_table do
      row :product_name
      row :category do |product|
        product.category.category_name  
      end
      row :availability
      row :price
      row :description
      row :on_sale
      row :new_arrival
      row :recently_updated
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
