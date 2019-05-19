class CreateDeal < ApplicationInteractor
  integer :negotiation_id
  object :user

  validate :negotiation_belons_to_user?

  def execute
    # TODO
  end

  private

  def negotiation
    @negotiation ||= Negotiation.find(negotiation_id)
  end

  def negotiation_belons_to_user?
    errors.add(:negotiation_id, :not_belongs) unless negotiation.user.id == user.id
  end
end
