# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    # Admin dashboard logic here
  end
end
