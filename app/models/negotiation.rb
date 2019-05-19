class Negotiation < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :owner, class_name: 'User', required: false
  belongs_to :accepter, class_name: 'User', required: false

  module TYPES
    REQUEST = 0
    OFFER = 1
  end

  module STATUSES
    OPENED = 0
    CONFIRMED = 1
    CANCELED = 2
    DONE = 3
  end

  enum type: { request: TYPES::REQUEST, offer: TYPES::OFFER }
  enum status: { opened: STATUSES::OPENED,
                 confirmed: STATUSES::CONFIRMED,
                 canceled: STATUSES::CANCELED,
                 done: STATUSES::DONE }
end
