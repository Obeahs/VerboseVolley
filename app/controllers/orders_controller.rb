# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  include OrdersHelper
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @cart = session[:cart] || {}
    @provinces = Province.where(name: ['Alberta', 'British Columbia', 'Manitoba', 'Ontario', 'Saskatchewan'])
  end

  def create
    @order = current_customer.orders.build(order_params)
    @cart = session[:cart] || {}
    @order.total_price = calculate_total_price

    if @order.save
      session[:cart] = nil
      redirect_to @order, notice: 'Order successfully created. Your items will be shipped to the nearest pickup location in your province.'
    else
      @provinces = Province.where(name: ['Alberta', 'British Columbia', 'Manitoba', 'Ontario', 'Saskatchewan'])
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:province_id)
  end

  def calculate_total_price
    total = @cart.sum { |id, quantity| Product.find(id).price * quantity }
    total + calculate_taxes(total, order_params[:province_id])
  end
end
