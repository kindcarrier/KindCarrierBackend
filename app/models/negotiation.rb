class Negotiation < ApplicationRecord
  enum type: { recipient: 0, sender: 1 }
  CREATE_PARAMS = attribute_names - %w[id created_at updated_at]
end
