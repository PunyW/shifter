class UserSerializer < ActiveModel::Serializer
  attributes :username, :token, :id, :email, :user_role
end