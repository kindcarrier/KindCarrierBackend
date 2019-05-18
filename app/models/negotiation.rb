class Negotiation < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :user
  
  enum type: { recipient: 0, deliveryman: 1 }
end
