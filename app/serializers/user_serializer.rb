class UserSerializer < ActiveModel::Serializer
  attributes :email, :first_name, :last_name, :token
end
