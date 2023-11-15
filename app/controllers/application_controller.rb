# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_user! # Add this line to enforce authentication for all controllers
  
    # ... other code ...
  end
  