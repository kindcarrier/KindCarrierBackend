FactoryBot.define do
  factory :deal do
    description { 'deal_description' }
    supplying_cost { rand(20..30) }
    negotiation_ids { [create(:negotiation, type: 'recipient').id, create(:negotiation, type: 'deliveryman').id] }
end
