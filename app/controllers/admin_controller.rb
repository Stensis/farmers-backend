class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def dashboard
    # Admin dashboard logic here
  end

  private

  def authorize_admin!
    # Ensure the current user is an admin
    unless current_user&.admin?
      render json: { error: 'Unauthorized access' }, status: :unauthorized
    end
  end
end
