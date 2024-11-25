ActiveAdmin.register Province do
  permit_params :name, :gst_rate, :pst_rate, :hst_rate

  filter :name

  index do
    selectable_column
    column :name
    column :gst_rate
    column :pst_rate
    column :hst_rate
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :gst_rate
      f.input :pst_rate
      f.input :hst_rate
    end
    f.actions
  end
end
