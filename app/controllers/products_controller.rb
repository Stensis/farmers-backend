class ProductsController < ApplicationController

  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authorize_farmer!, only: %i[edit create update destroy]

  before_action :authenticate_farmer!, only: %i[new create edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
    render json: @products
  end

  # GET /products/1 or /products/1.json
  def show
    render json: { product: @product, reviews: @product.reviews }
  end

  # GET /products/new
  def new
    @product = current_farmer.products.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = current_farmer.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
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
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # to search for the product
  def search
    query = params[:query]
    category_id = params[:category_id]

    # Implement search logic based on the query and filters
    @results = Product.search(query, category_id)

    render json: @results
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :category_id)
  end

  def authorize_farmer!
    unless current_user.farmer? && current_user == @product.farmer
      redirect_to root_path, alert: "You are not authorized to perform this action on this product."
    end
  end
end
