# frozen_string_literal: true

class SessionsController < ApiController
  skip_before_action :authenticate_user, only: [:create]

  def create
    user = User.authenticate!(params[:email], params[:password])
    render json: user, status: :ok
  end
end
