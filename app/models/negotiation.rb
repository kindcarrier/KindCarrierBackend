class Negotiation < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :owner, class_name: 'User', optional: true
  belongs_to :accepter, class_name: 'User', optional: true
  enum type: { request: 0, offer: 1 }
end
