class NegotiationsController < SmartController
  skip_before_action :authenticate_user, only: [:index]

  show
  create allowed_params: { negotiation: %i[name photo description service_cost type
                                           owner_id] + [address_from: %i[country city state street latitude longitude],
                                                        address_to: %i[country city state street latitude longitude]] }

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

  def creating_params(allowed_params)
    params.permit(allowed_params)[:negotiation]
  end

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
