ActiveAdmin.register Province do
  permit_params :name, :gst_rate, :pst_rate, :hst_rate, :postal_code
  
end
