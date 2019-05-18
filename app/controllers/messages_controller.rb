class MessagesController < ApiController
  def create
    message = Message.create!(user_id: current_user.id, deal_id: deal_id, text: text)
    render json: message, status: :created
  end
end
