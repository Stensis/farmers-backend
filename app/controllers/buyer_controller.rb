# app/controllers/buyer_controller.rb
class BuyerController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    # Buyer dashboard logic here
  end
end
