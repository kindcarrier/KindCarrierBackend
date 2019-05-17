# frozen_string_literal: true

require 'active_interaction'

class CreateUser < ApplicationInteractor
  string :first_name
  string :last_name
  string :email
  string :password

  def execute
    User.create!(inputs)
  end
end
