class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authorize_buyer!, only: %i[new create]
  before_action :authorize_farmers!, only: %i[edit update]

  # ... existing actions ...

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.buyer = current_user if current_user.buyer?

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # ... existing private methods ...

  def authorize_buyer!
    return if current_user.buyer?

    render json: { error: 'Unauthorized access' }, status: :unauthorized
  end

  def authorize_farmers!
    return if current_user.farmer?

    render json: { error: 'Unauthorized access' }, status: :unauthorized
  end
end
