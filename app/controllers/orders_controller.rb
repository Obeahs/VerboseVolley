class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :initialize_cart, only: [:new, :create]

  def index
    @orders = current_customer.orders
  end

  def new
    @order = Order.new
    @order.address = current_customer.address if customer_signed_in?
    @order.province_id = current_customer.province_id if customer_signed_in? && current_customer.province.present?
    @products = Product.where(id: session[:cart].keys)
    @cart = session[:cart]
    calculate_totals
  end

  def create
    @order = current_customer.orders.build(order_params)
    province = Province.find(params[:order][:province_id])
    @order.total_price = calculate_total_price(province)

    if @order.save
      @order.create_order_items(@products, @cart)
      session[:cart] = {}
      redirect_to @order, notice: 'Order successfully created. Your items will be shipped to the nearest pickup location in your province.'
    else
      @products = Product.where(id: session[:cart].keys)
      @cart = session[:cart]
      calculate_totals
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :province_id)
  end

  def calculate_taxes(subtotal, province)
    gst = province.gst_rate * subtotal
    pst = province.pst_rate * subtotal
    hst = province.hst_rate * subtotal
    gst + pst + hst
  end

  def calculate_total_price(province)
    subtotal = @products.sum { |product| product.price * @cart[product.id.to_s].to_i }
    taxes = calculate_taxes(subtotal, province)
    subtotal + taxes
  end

  def calculate_totals
    @subtotal = @products.sum { |product| product.price * @cart[product.id.to_s].to_i }
    province = Province.find_by(id: @order.province_id)
    @taxes = province ? calculate_taxes(@subtotal, province) : 0
    @total = @subtotal + @taxes
  end

  def 
    past_orders @orders = current_customer.orders.includes(:order_items, :products)
  end
  
  def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
    @products = Product.where(id: @cart.keys)
  end
end
