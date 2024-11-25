class CartsController < ApplicationController
  before_action :initialize_cart, only: [:add, :remove, :update, :show]

  def show
    @products = Product.where(id: @cart.keys)
  end

  def add
    id = params[:id]
    @cart[id] ||= 0
    @cart[id] += 1
    redirect_to cart_path, notice: "Product added to cart"
  end

  def remove
    id = params[:id]
    @cart.delete(id)
    redirect_to cart_path, notice: "Product removed from cart"
  end

  def update
    id = params[:id]
    quantity = params[:quantity].to_i
    if quantity <= 0
      @cart.delete(id)
    else
      @cart[id] = quantity
    end
    redirect_to cart_path, notice: "Cart updated"
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end
end
