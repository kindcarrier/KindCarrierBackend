class UsersController < ApiController
  skip_before_action :authenticate_user, only: [:create]

  def create
    user = CreateUser.run!(create_params)
    render json: user, status: :created
  end

  def update
    user = UpdateUser.run!(update_params)
    render json: user, status: :created
  end

  private

  def create_params
    params.permit(:first_name, :last_name, :email, :password, :avatar)
  end

  def update_params
    params.permit(:first_name, :last_name, :avatar)
  end
end
