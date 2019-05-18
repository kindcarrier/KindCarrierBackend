class SmartController < ApiController
  BASE_METHODS=[:index, :show, :create, :update]

  class << self
    def create(allowed_params:)
      define_method :create do 
        record = model.create!(params.permit(allowed_params))
        render json: record, status: :created
      end
    end

    def update(allowed_params:)
      define_method :update do
        record = model.update!(params.permit(allowed_params))
        render json: record, status: :updated
      end
    end

    def index
      define_method :index do
        records = model.all.page(page).per(per_page)
        render json: records, status: :ok
      end
    end

    def show
      define_method :show do
        record = model.find(params[:id])
        render json: record, status: :ok
      end
    end
  end

  private

  def model
    @model ||= controller_name.singularize.titleize.constantize
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