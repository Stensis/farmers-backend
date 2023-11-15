class Api::V1::Farmers::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    def create
      build_resource(sign_up_params)
  
      resource.save
      render_resource(resource)
    end
  
    private
  
    def sign_up_params
      params.require(:farmer).permit(:full_name, :email, :tel, :location, :password, :password_confirmation)
    end
  end
  