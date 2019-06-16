class CancelNegotiation < ApplicationInteractor
  object :negotiation
  object :user

  validate :check_for_user, :check_for_status

  def execute
    negotiation.update!(status: :canceled)
    negotiation
  end

  def check_for_user
    errors.add(:negotiation, :not_belongs) unless user_linked_to_negotiation?
  end

  def check_for_status
    errors.add(:negotiation, :not_confirmed) unless negotiation.status == 'confirmed'
  end

  def user_linked_to_negotiation?
    negotiation.owner == user || negotiation.accepter == user
  end
end
