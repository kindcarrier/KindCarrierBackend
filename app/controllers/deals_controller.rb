class DealsController < SmartController
  # def create
  #   deal = CreateDeal.run!(create_params)
  #   render json: deal
  # end
  create allowed_params: Deals.attribute_names - %w[id created_at updated_at]
  index
  show

  def create_params
    params.merge(user: current_user)
  end
end
