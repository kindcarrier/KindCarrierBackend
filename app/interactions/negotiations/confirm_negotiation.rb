class ConfirmNegotiation < ApplicationInteractor
  object :negotiation
  object :user

  validate :check_for_status, :check_for_user

  def execute
    negotiation.update!(status: :confirmed, accepter_id: user.id)
    negotiation
  end

  private

  def check_for_user
    errors.add(:negotiation, :not_belongs) unless user_linked_to_negotiation?
  end

  def user_linked_to_negotiation?
    negotiation.owner == user || negotiation.accepter == user
  end

  def check_for_status
    # error.add(:negotiation, :not_acceptab)
  end
end
