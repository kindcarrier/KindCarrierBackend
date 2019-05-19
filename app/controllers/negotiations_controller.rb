class NegotiationsController < SmartController
  create allowed_params: Negotiation.attribute_names - %w[id created_at updated_at]
  show

  def index
    negotiations = FetchNegotiations.run!(params)
    render json: negotiations, status: :ok
  end
end
