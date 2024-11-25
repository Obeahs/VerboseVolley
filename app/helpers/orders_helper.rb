# app/helpers/orders_helper.rb
module OrdersHelper
    def calculate_taxes(subtotal, province)
      gst = province.gst_rate * subtotal
      pst = province.pst_rate * subtotal
      hst = province.hst_rate * subtotal
      gst + pst + hst
    end
  end
  