# app/controllers/farmer_controller.rb
class FarmerController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    # Farmer dashboard logic here
  end
end
