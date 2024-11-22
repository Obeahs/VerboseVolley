# app/models/province.rb
class Province < ApplicationRecord
    def postal_code
      case name
      when "Alberta"
        "T0A 0A0"
      when "British Columbia"
        "V0A 0A0"
      when "Manitoba"
        "R0A 0A0"
      when "Ontario"
        "K0A 0A0"
      when "Quebec"
        "G0A 0A0"
      when "Saskatchewan"
        "S0A 0A0"
      else
        "X0X 0X0" # Generic fallback
      end
    end
  
    def label_method
      "123 Warehouse st in #{name} at #{postal_code}"
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "gst_rate", "hst_rate", "id", "id_value", "name", "pst_rate", "updated_at"]
      end
    
  end
  