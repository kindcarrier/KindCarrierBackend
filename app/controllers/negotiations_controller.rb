class NegotiationsController < SmartController
  create allowed_params: Negotiation.attribute_names - %w[id created_at updated_at]
  show

  def index
    negotiations = FetchNegotiations.run!(params)
    render json: negotiations, status: :ok
  end

  def confirm
    negotiation = ConfirmNegotiation.run!(change_status_params)
    render json: negotiation, status: :ok
  end

  def cancel
    negotiation = CancelNegotiation.run!(change_status_params)
    render json: negotiation, status: :ok
  end

  private

  def change_status_params
    {
      negotiation: negotiation,
      user: current_user
    }
  end

  def negotiation
    @negotiation ||= Negotiation.find(params[:id])
  end
end
