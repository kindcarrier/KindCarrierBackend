class MessagesController < ApiController
  def index
    messages = FetchMessages.run!(default_params)
    render json: messages, status: :ok
  end

  def create
    message = CreateMessage.run!(create_params)
    render json: message, status: :created
  end

  private

  def create_params
    default_params.merge(text: params[:text])
  end

  def default_params
    {
      negotiation_id: params[:negotiation_id],
      user: current_user
    }
  end
end
