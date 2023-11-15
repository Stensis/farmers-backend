class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_farmer!, only: [:new, :create, :edit, :update, :destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
    render json: @products
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = current_farmer.products.build
  end

  # GET /products/1/edit
  def edit
    # Ensure that only the farmer who created the product can edit it
    unless current_farmer == @product.farmer
      redirect_to root_path, alert: "You are not authorized to edit this product."
    end
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
    # Ensure that only the farmer who created the product can update it
    unless current_farmer == @product.farmer
      redirect_to root_path, alert: "You are not authorized to update this product."
      return
    end

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
    # Ensure that only the farmer who created the product can delete it
    unless current_farmer == @product.farmer
      redirect_to root_path, alert: "You are not authorized to delete this product."
      return
    end

    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :category_id)
  end
end
