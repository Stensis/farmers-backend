class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  def auth_check
    if user_signed_in?
      render_user_response(current_user, 'User is signed in.')
    else
      render_unauthorized_response('User is not signed in.')
    end
  end

  def login
    Rails.logger.info("Login parameters: #{params.inspect}")
  
    self.resource = warden.authenticate!(auth_options)
  
    Rails.logger.info("User authenticated: #{resource.inspect}")
  
    if user_signed_in?
      render_user_response(current_user, 'Logged in successfully.')
    else
      render_unauthorized_response('Invalid credentials.')
    end
  end

  # def login
  #   Rails.logger.info("Login parameters: #{params.inspect}")
  
  #   self.resource = warden.authenticate!(auth_options)
  
  #   if resource
  #     Rails.logger.info("User found: #{resource.inspect}")
  #     render_user_response(current_user, 'Logged in successfully.')
  #   else
  #     render_unauthorized_response('Invalid credentials.')
  #   end
  # end
  
  
  # def login
  #   self.resource = warden.authenticate!(auth_options)

  #   if user_signed_in?
  #     render_user_response(current_user, 'Logged in successfully.')
  #   else
  #     render_unauthorized_response('Invalid credentials.')
  #   end
  # end

  def destroy
    # Invalidate both access and refresh tokens
    if user_signed_in?
      current_user.update(jti: SecureRandom.uuid)
      render json: { status: 200, message: 'Logged out successfully.' }, status: :ok
    else
      render_unauthorized_response("Couldn't find an active session.")
    end
  end

  private

  def render_user_response(user, message)
    access_token = generate_access_token(user)
    refresh_token = generate_refresh_token(user)

    Rails.logger.info("access_token: #{access_token}")
    Rails.logger.info("refresh_token: #{refresh_token}")

    render json: {
      status: {
        code: 200,
        message: message,
        data: { user: UserSerializer.new(user).serializable_hash[:data][:attributes] }
      },
      access_token: access_token,
      refresh_token: refresh_token
    }, status: :ok
  end

  def render_unauthorized_response(message)
    render json: {
      status: 401,
      message: message
    }, status: :unauthorized
  end

  def generate_access_token(user)
    JsonWebToken.encode(user_id: user.id, exp: 1.week.from_now.to_i)
  end

  def generate_refresh_token(user)
    JsonWebToken.encode(user_id: user.id, exp: 2.weeks.from_now.to_i)
  end
end
