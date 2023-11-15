class Api::V1::SessionsController < ApplicationController
    def create
        # Assuming email is a unique identifier for both Buyer and Farmer
        buyer = Buyer.find_by(email: params[:email])
        farmer = Farmer.find_by(email: params[:email])
    
        # Check if either a buyer or farmer is found
        user = buyer || farmer
    
        if user&.authenticate(params[:password])
          token = encode_token(user_id: user.id)
          render json: { token: token }
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    
      private
    
      def encode_token(payload)
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
      end
  end
  
  
# app/controllers/sessions_controller.rb

# class SessionsController < Devise::SessionsController
#     respond_to :json
  
#     def create
#       super { |resource| render json: { message: 'Logged in successfully.' } and return }
#     end
#   end
  