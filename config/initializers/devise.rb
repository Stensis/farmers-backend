# frozen_string_literal: true

Devise.setup do |config|
  # Use Rails.application.credentials to access the secret key
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.devise_jwt_secret_key
    jwt.dispatch_requests = [
      ['POST', %r{^/login$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/logout$}]
    ]
    jwt.expiration_time = 1.day.to_i
  end

  config.navigational_formats = []

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  # Remove the block below, as it seems unnecessary and might be causing the issue.
  config.to_param do
    JwtBlacklist
  end
end
