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
    @order.cart_id = @cart.id
    @order.total_price = calculate_total_price

    if @order.save
      @order.add_cart_items(@cart)
      clear_cart(@cart)
      redirect_to @order, notice: 'Order successfully placed.'
    else
      render :new
    end
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  private

  def set_cart
    @cart = current_customer.cart
  end

  def order_params
    params.require(:order).permit(:address, :province_id, :cart_id, :credit_card_number, :expiration_date, :cvv)
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

  def clear_cart(cart)
    cart.products_carts.destroy_all
  end

  include OrdersHelper
end
