class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :full_name, :email, :tel, :location
end
