# app/controllers/api/v1/buyers/registrations_controller.rb
class Api::V1::Buyers::RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token, only: [:create]
    respond_to :json
  
    def create
      build_resource(sign_up_params)
  
      if resource.save
        sign_in(:buyer, resource, store: false)
        render json: { message: 'Buyer was successfully created and signed in.' }
      else
        render json: { error: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end
  
    private
  
    def sign_up_params
      params.require(:buyer).permit(:full_name, :email, :tel, :location, :password, :password_confirmation)
    end
  
    protected
  
    def after_sign_up_path_for(resource)
      '/api/v1/buyers/signup'
    end
  end
  