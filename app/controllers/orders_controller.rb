class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
  end

  def new
    @order = Order.new
    @cart = current_cart
    @provinces = Province.all
  end

  def create
    @order = current_customer.orders.build(order_params)
    @order.cart = current_cart
    @order.total_price = @order.cart.total_price + calculate_taxes(@order.cart.total_price)

    if @order.save
      @order.create_order_items(current_cart.products_carts)
      session[:cart] = nil
      redirect_to @order, notice: 'Order successfully created. Your items will be shipped to the nearest pickup location in your province.'
    else
      @cart = current_cart
      @provinces = Province.all
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:province_id)
  end

  def calculate_taxes(total)
    province = Province.find(order_params[:province_id])
    gst = province.gst_rate * total
    pst = province.pst_rate * total
    hst = province.hst_rate * total
    gst + pst + hst
  end

  def current_cart
    if session[:cart_id]
      cart = Cart.find(session[:cart_id])
    else
      cart = Cart.create! # Create and save a new cart
      session[:cart_id] = cart.id
    end

    add_products_to_cart(cart, session[:cart])
    
    cart
  end

  def add_products_to_cart(cart, session_cart)
    session_cart.each do |id, quantity|
      quantity.times { cart.add_product(id) }
    end
  end
end
