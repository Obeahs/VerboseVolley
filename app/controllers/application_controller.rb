class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:customer_name, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:customer_name, :phone_number])
  end

  private

  def current_cart
    @current_cart ||= begin
      if session[:cart_id]
        Cart.find(session[:cart_id])
      else
        cart = Cart.create!
        session[:cart_id] = cart.id
        cart
      end
    end
  end
end
