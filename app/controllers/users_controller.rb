class UsersController < ApiController
  skip_before_action :authenticate_user, only: [:create]

  def create
    user = CreateUser.run!(user_params)
    render json: user, status: :created
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :avatar)
  end
end
