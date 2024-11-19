class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
  end

  def add
    id = params[:id]
    session[:cart] ||= {}
    session[:cart][id] ||= 0
    session[:cart][id] += 1
    redirect_to cart_path, notice: "Product added to cart"
  end

  def remove
    id = params[:id]
    session[:cart].delete(id)
    redirect_to cart_path, notice: "Product removed from cart"
  end

  def update
    id = params[:id]
    quantity = params[:quantity].to_i
    if quantity <= 0
      session[:cart].delete(id)
    else
      session[:cart][id] = quantity
    end
    redirect_to cart_path, notice: "Cart updated"
  end
end
