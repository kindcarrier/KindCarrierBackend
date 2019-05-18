class NegotiationsController < SmartController
  create allowed_params: Negotiation.attribute_names - %w[id created_at updated_at]
  index
  show
end
