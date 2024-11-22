class OrdersController < ApplicationController
    before_action :authenticate_customer!
  
    def new
      @order = Order.new
      @cart = session[:cart] || {}
      @provinces = Province.all
    end
  
    def create
      @order = current_customer.orders.build(order_params)
      @order.total_price = calculate_total_price
  
      if @order.save
        session[:cart] = nil
        redirect_to @order, notice: 'Order successfully created.'
      else
        render :new
      end
    end
  
    private
  
    def order_params
      params.require(:order).permit(:customer_id, :address, :province_id)
    end
  
    def calculate_total_price
      cart = session[:cart] || {}
      total = 0
      cart.each do |id, quantity|
        product = Product.find(id)
        total += product.price * quantity
      end
      total += calculate_taxes(total)
      total
    end
  
    def calculate_taxes(total)
      province = Province.find(order_params[:province_id])
      gst = province.gst_rate * total
      pst = province.pst_rate * total
      hst = province.hst_rate * total
      gst + pst + hst
    end
  end
  