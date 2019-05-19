class ConfirmNegotiation < ApplicationInteractor
  object :negotiation
  object :user

  validate :check_for_status

  def execute
    negotiation.update!(status: :confirmed, accepter_id: user.id)
    negotiation
  end

  private

  def check_for_status
    # error.add(:negotiation, :not_acceptab)
  end
end
