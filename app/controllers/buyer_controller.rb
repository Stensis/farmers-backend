# app/controllers/buyer_controller.rb
class BuyerController < ApplicationController
  before_action :authenticate_user!
  before_action :load_buyer, only: [:dashboard, :order_history, :place_order, :cancel_order]

  def dashboard
    authorize! :read, :dashboard
    # Logic for displaying buyer dashboard, e.g., order summaries, delivery status, etc.
  end

  def order_history
    authorize! :read, :order_history
    @orders = @buyer.orders.includes(:product)
    # Additional logic for displaying order history
  end

  def place_order
    authorize! :create, :order
    # Logic for placing an order, adding products to the shopping cart, etc.
  end

  def cancel_order
    authorize! :destroy, :order
    order = @buyer.orders.find(params[:order_id])
    # Logic for canceling an order, updating order status, etc.
  end

  # Add more methods as needed for buyer-related functionality

  private

  def load_buyer
    @buyer = current_user if current_user.buyer?
    redirect_to root_path, alert: 'You are not authorized.' unless @buyer
  end
end
