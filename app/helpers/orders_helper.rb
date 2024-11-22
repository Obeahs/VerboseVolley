module OrdersHelper
    def calculate_taxes(total, province_id)
      province = Province.find(province_id)
      gst = province.gst_rate * total
      pst = province.pst_rate * total
      hst = province.hst_rate * total
      gst + pst + hst
    end
  end
  