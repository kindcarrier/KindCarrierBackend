class Negotiation < ApplicationRecord
  enum type: { recipient: 0, sender: 1 }
end
