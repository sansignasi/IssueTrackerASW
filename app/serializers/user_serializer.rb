class UserSerializer < ActiveModel::Serializer
  attributes :id,:first_name,:email,:uid,:token
end
