class CartsController < ApplicationController
  def add
    @cart = current_cart
    @cart.add_product(params[:id])
    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def remove
    @cart = current_cart
    product_cart = @cart.products_carts.find_by(product_id: params[:id])
    product_cart.destroy if product_cart
    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  def update
    @cart = current_cart
    product_cart = @cart.products_carts.find_by(product_id: params[:id])
    if product_cart
      product_cart.update(quantity: params[:quantity])
    end
    redirect_to cart_path, notice: 'Cart updated.'
  end

  def show
    @cart = current_cart
  end
end
