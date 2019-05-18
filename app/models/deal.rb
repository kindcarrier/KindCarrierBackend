class Deal < ApplicationRecord
  validates :negotiation_ids, presence: true
  before_validation :check_for_two_negotiations

  def check_for_two_negotiations
    return errors.add(:base, 'must have 2 negotiations') unless negotiation_ids.size == 2
    return errors.add(:base, 'must have recipient and deliveryman') unless both_types_negotiations_present?
  end

  def negotiations
    @negotiations ||= Negotiation.where(id: negotiation_ids)
  end

  def both_types_negotiations_present?
    negotiations.recipient && negotiations.deliveryman
  end
end