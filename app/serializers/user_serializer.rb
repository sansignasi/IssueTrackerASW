class UserSerializer < ActiveModel::Serializer
  attributes :uid, :token, :id, :first_name, :email
  
end
