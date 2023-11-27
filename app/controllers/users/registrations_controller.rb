class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  def create
    build_resource(sign_up_params)
    # Set the role based on the provided parameter (default to 'Buyer' if not specified)
    resource.role = params[:user][:role] if params[:user].present? && params[:user][:role].present?
  
    if resource.save
      sign_up(resource_name, resource)
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
    else
      clean_up_passwords resource
      puts "Errors: #{resource.errors.full_messages}"
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
  
  private
  def sign_up_params
    params.require(:user).permit(
      :full_name,
      :email,
      :password,
      :password_confirmation,
      :tel,
      :location,
      :role 
    )
  end

end
