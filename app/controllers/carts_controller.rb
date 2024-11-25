class CartsController < ApplicationController
  before_action :authenticate_customer!

  def show
    @cart = current_customer.cart || Cart.create(customer: current_customer)
    @products = @cart.products_carts.map(&:product) || []
  end

  def add
    product = Product.find(params[:id])
    current_customer.cart.add_product(product.id)
    redirect_to cart_path
  end

  def remove
    product = Product.find(params[:id])
    current_customer.cart.remove_product(product.id)
    redirect_to cart_path
  end

  def update
    product = Product.find(params[:id])
    current_customer.cart.update_product(product.id, params[:quantity].to_i)
    redirect_to cart_path
  end

  def delete_all_products
    current_customer.cart.delete_all_products
    redirect_to cart_path, notice: 'All items have been removed from your cart.'
  end

  def save_and_create_new_cart
    current_cart = current_customer.cart
    current_customer.update(cart: Cart.create(customer: current_customer))
  end
end
