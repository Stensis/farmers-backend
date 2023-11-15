# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authorize_buyer!, only: %i[new create cart show add_to_cart confirm cancel mark_delivered]

  # GET /orders
  def index
    @orders = Order.all
    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    # Logic for editing an order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @order.buyer = current_user if current_user.buyer?

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      notify_users(@order, 'Order status has changed.')
      # ... other update logic
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    head :no_content
  end

  # GET /orders/cart
  def cart
    @orders = current_user.orders.in_cart.includes(:product)
    render json: @orders
  end

  # POST /orders/add_to_cart
  def add_to_cart
    product = Product.find(params[:product_id])
    order = current_user.orders.in_cart.find_or_initialize_by(product: product)

    order.quantity += params[:quantity].to_i
    order.save

    render json: { message: 'Product added to the cart successfully.' }
  end

  # POST /orders/confirm
  def confirm
    order = current_user.orders.in_cart.first
    order.confirm_order

    render json: { message: 'Order confirmed successfully.' }
  end

  # POST /orders/cancel
  def cancel
    order = current_user.orders.in_cart.first
    order.cancel_order

    render json: { message: 'Order cancelled successfully.' }
  end

  # POST /orders/mark_delivered
  def mark_delivered
    order = current_user.orders.find(params[:order_id])
    order.mark_delivered

    render json: { message: 'Order marked as delivered successfully.' }
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:product_id, :quantity, :status)
  end

  def authorize_buyer!
    return if current_user.buyer?

    render json: { error: 'Unauthorized access' }, status: :unauthorized
  end

  def notify_users(order, message)
    User.where(id: [@order.buyer_id, @order.product.farmer_id]).each do |user|
      user.notifications.create(message: message)
    end
  end
end
