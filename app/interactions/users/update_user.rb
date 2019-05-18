require 'active_interaction'

class UpdateUser < ApplicationInteractor
  string :first_name
  string :last_name
  string :avatar

  def execute
    User.update!(inputs)
  end
end
