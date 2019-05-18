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

  def index
    records = model.all.page(page).per(per_page)
    render json: records, status: :ok
  end

  def show
    record = model.find(params[:id])
    render json: record, status: :ok
  end

  def create
    record = model.create!(permitted_create_params)
    render json: record, status: :created
  end

  private

  def model
    @model ||= controller_name.singularize.titleize.constantize
  end

  def permitted_create_params
    params.permit(model::CREATE_PARAMS)
  end

  def page
    params[:page] || 1
  end

  MAX_PER_PAGE = 100

  def per_page
    page_size = params[:per_page] || 50
    page_size > MAX_PER_PAGE ? MAX_PER_PAGE : page_size
  end
end
