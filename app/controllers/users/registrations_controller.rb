# class Users::RegistrationsController < Devise::RegistrationsController
#   include RackSessionsFix
#   respond_to :json
#   private

#   def respond_with(current_user, _opts = {})
#     if resource.persisted?
#       render json: {
#         status: {code: 200, message: 'Signed up successfully.'},
#         data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
#       }
#     else
#       render json: {
#         status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
#       }, status: :unprocessable_entity
#     end
#   end
# end


class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  def create
    build_resource(sign_up_params)

    # Set the role based on the provided parameter (default to 'Buyer' if not specified)
    resource.role = params[:role] || 'Buyer'

    if resource.save
      sign_up(resource_name, resource)
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
    else
      clean_up_passwords resource
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :tel, :location)
  end
end
