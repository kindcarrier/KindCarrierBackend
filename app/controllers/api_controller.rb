class ApiController < ActionController::API
  include Sorcery::Controller

  before_action :authenticate_user

  rescue_from StandardError, with: :internal_error
  rescue_from Exceptions::UnauthorizedError, with: :unauthorized_error_response

  def authenticate_user
    user = User.find_by(token: request.headers[:Authorization])
    raise Exceptions::UnauthorizedError, 'Unauthorized' unless user

    auto_login(user)
  end

  def unauthorized_error_response(exception)
    render json: { message: exception.message,
                   code: Api::UNAUTHORIZED_ERROR },
           status: :unauthorized
  end

  def internal_error(exception)
    render json: { message: exception.message,
                   code: Api::INTERNAL_SERVER_ERROR },
           status: :internal_server_error
  end
end
