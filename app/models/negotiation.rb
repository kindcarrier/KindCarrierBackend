class Negotiation < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :owner, class_name: 'User', required: false
  belongs_to :accepter, class_name: 'User', required: false
  module TYPES
    REQUEST = 0
    OFFER = 1
  end
  enum type: { request: TYPES::REQUEST, offer: TYPES::OFFER }
end
