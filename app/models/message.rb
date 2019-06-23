class Message < ApplicationRecord
  belongs_to :negotiation
  belongs_to :user

  validates :negotiation, :user, :text, presence: true
end
