class ProductsCart < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :product_id, presence: true
  validates :cart_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "id", "product_id", "updated_at"]
  end

  def index
    if params[:category].present?
      @category = Category.find(params[:category])
      @products = @category.products.page(params[:page]).per(10)
    else
      @products = Product.all.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
  
end

