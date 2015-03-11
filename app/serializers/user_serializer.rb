class UserSerializer < ActiveModel::Serializer
  attributes :username, :token, :id, :email
end