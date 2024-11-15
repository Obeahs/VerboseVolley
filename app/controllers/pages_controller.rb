class PagesController < ApplicationController
  def home
    @products = Product.all.page(params[:page]).per(10)  #
  end

  def about
  end

  def contact
  end
end
