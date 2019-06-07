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
    errors.add(:user, :is_owner) if user_is_owner?
  end

  def user_is_owner?
    negotiation.owner == user
  end

  def check_for_status
    errors.add(:negotiation, :has_wrong_status) unless negotiation.status == 'opened'
  end
end
