class SmartController < ApiController
  class << self
    def create(allowed_params:)
      define_method :create do 
        created_record = model.create!(params.permit(allowed_params))
        render json: created_record, status: :created
      end
    end

    def update(allowed_params:)
      define_method :update do
        updated_record = record_by_id.update!(params.permit(allowed_params))
        render json: updated_record, status: :updated
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
        render json: record_by_id, status: :ok
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

  def record_by_id
    model.find(params[:id])
  end
end