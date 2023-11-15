class ApplicationController < ActionController::API
    include ActionController::RequestForgeryProtection
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :null_session, if: -> { request.format.json? }
  
    def current_farmer
      current_farmers.first
    end
  
    def current_buyer
      current_buyers.first
    end
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :email, :password, :password_confirmation])
    end
  end
  