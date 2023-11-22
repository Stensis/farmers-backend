# app/models/jwt_blacklist.rb
class JwtBlacklist < ApplicationRecord
    include Devise::JWT::RevocationStrategies::Denylist
  
    self.table_name = 'jwt_blacklist'
end
  