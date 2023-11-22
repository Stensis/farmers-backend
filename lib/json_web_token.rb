# app/lib/json_web_token.rb
require 'jwt'

class JsonWebToken
  SECRET_KEY = Rails.application.credentials.devise_jwt_secret_key

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  # def self.decode(token)
  #   decoded_array, = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
  #   HashWithIndifferentAccess.new(user_id: decoded_array[0]['user_id'])
  # end

  def self.decode(token)
    decoded_array, = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    Rails.logger.info("Decoded token: #{decoded_array.inspect}")
    HashWithIndifferentAccess.new(user_id: decoded_array[0]['user_id'])
  end
  
end
