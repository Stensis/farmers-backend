# app/controllers/application_controller.rb
# class ApplicationController < ActionController::Base
#     protect_from_forgery with: :exception
#     before_action :authenticate_user! # Add this line to enforce authentication for all controllers
  
#     # ... other code ...
#   end
  
  class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?
    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
    end
  end