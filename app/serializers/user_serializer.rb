# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :email, :first_name, :last_name, :token
end
