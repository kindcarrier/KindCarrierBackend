class MessagesController < ApiController
  def index
    messages = FetchMessages.run!(params)
    render json: messages, status: :ok
  end

  def create
    message = Message.create!(user_id: current_user.id, deal_id: deal_id, text: text)
    render json: message, status: :created
  end
end
