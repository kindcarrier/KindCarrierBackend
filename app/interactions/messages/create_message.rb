class CreateMessage < ApplicationInteractor
  string :text
  integer :deal_id
  object :user

  validate :deal_of_current_user?
  validates :deal, presence: true

  def execute
    Message.create!(text: text,
                    deal: deal,
                    user: user)
  end

  private

  def deal_of_current_user?
    errors.add(:deal_id, :not_belongs) unless deal_user_ids.include?(user.id)
  end

  def deal_user_ids
    deal.negotiations.map do |negotiation|
      negotiation.user.id
    end
  end

  def deal
    @deal ||= Deal.find(deal_id)
  end
end
