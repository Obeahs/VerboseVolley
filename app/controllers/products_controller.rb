class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @categories = Category.all
    @products = Product.all

    @products = @products.where("product_name LIKE ?", "%#{params[:search]}%") if params[:search].present?
    @products = @products.where(on_sale: true) if params[:on_sale].present? && params[:on_sale] == 'true'
    @products = @products.where(new_arrival: true) if params[:new_arrival].present? && params[:new_arrival] == 'true'
    @products = @products.where(recently_updated: true) if params[:recently_updated].present? && params[:recently_updated] == 'true'

    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?

    @products = @products.page(params[:page]).per(10)
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
  
    @product.availability = ActiveModel::Type::Boolean.new.cast(params[:product][:availability])
    @product.on_sale = ActiveModel::Type::Boolean.new.cast(params[:product][:on_sale])
    @product.new_arrival = ActiveModel::Type::Boolean.new.cast(params[:product][:new_arrival])
    @product.recently_updated = ActiveModel::Type::Boolean.new.cast(params[:product][:recently_updated])
  
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        Rails.logger.debug @product.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /products/1 or /products/1.json
  def update
    # Convert boolean values before updating
    @product.availability = ActiveModel::Type::Boolean.new.cast(params[:product][:availability])
    @product.on_sale = ActiveModel::Type::Boolean.new.cast(params[:product][:on_sale])
    @product.new_arrival = ActiveModel::Type::Boolean.new.cast(params[:product][:new_arrival])
    @product.recently_updated = ActiveModel::Type::Boolean.new.cast(params[:product][:recently_updated])

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:product_name, :category_id, :availability, :price, :image, :description, :on_sale, :new_arrival, :recently_updated)
    end
end
