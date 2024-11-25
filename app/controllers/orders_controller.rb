class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart, only: [:new, :create]

  def new
    @order = Order.new
    @order.address = current_customer.address
    @order.province_id = current_customer.province_id if current_customer.province.present?
  end

  def create
    @cart = current_customer.cart
    @order = current_customer.orders.build(order_params)
    @order.cart_id = @cart.id # Ensure cart_id is set on the order
    @order.total_price = calculate_total_price
    @order.status = 'pending'

    if @order.save
      @order.add_cart_items(@cart)
      @cart.products_carts.destroy_all
      redirect_to @order, notice: 'Order successfully created.'
    else
      render :new
    end
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  def index
    @orders = current_customer.orders
  end

  private

  def set_cart
    @cart = current_customer.cart
  end

  def order_params
    params.require(:order).permit(:address, :province_id, :cart_id)
  end

  def calculate_total_price
    subtotal = @cart.products_carts.sum { |item| item.product.price * item.quantity }
    province = Province.find(@order.province_id)
    taxes = calculate_taxes(subtotal, province)
    subtotal + taxes
  end

  def calculate_taxes(subtotal, province)
    gst = province.gst_rate * subtotal
    pst = province.pst_rate * subtotal
    hst = province.hst_rate * subtotal
    gst + pst + hst
  end

  include OrdersHelper
end
