class CreateMessage < ApplicationInteractor
  string :text
  integer :negotiation_id
  object :user

  validate :deal_of_current_user?
  validates :negotiation, presence: true

  def execute
    Message.create!(text: text,
                    negotiation: negotiation,
                    user: user)
  end

  private

  def check_for_current_user
    errors.add(:negotiation_id, :not_belongs) unless negotiation_linked_to_user?
  end

  def negotiation
    @negotiation ||= Negotiation.find(deal_id)
  end

  def negotiation_linked_to_user?
    negotiation.owner == user || negotiation.accepter == user
  end
end
