class CancelNegotiation < ApplicationInteractor
  object :negotiation
  object :user

  validate :check_for_user

  def execute
    negotiation.update!(status: :cancel)
    negotiation
  end

  def check_for_user
    errors.add(:negotiation, :not_belongs) unless user_linked_to_negotiation?
  end

  def user_linked_to_negotiation?
    negotiation.owner == user || negotiation.accepter == user
  end
end
