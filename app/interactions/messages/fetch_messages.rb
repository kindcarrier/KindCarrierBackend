class FetchMessages < ApplicationInteractor
  integer :negotiation_id
  object :user

  validate :check_for_current_user

  def execute
    negotiation.messages.order(:created_at)
  end

  private

  def negotiation
    @negotiation ||= Negotiation.find(negotiation_id)
  end

  def check_for_current_user
    errors.add(:negotiation, :not_belongs) unless negotiation_linked_to_user?
  end

  def negotiation_linked_to_user?
    negotiation.owner == user || negotiation.accepter == user
  end
end
