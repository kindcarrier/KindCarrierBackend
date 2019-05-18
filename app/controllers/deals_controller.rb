class DealsController < SmartController
  create allowed_params: Deals.attribute_names - %w[id created_at updated_at]
  index
  show
end