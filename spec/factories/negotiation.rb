FactoryBot.define do
  factory :negotiation do
    association :user
    name { FFaker::Name.name }
    description { 'negotiation_description' }
    service_cost { rand(10..20) }
    country { FFaker::Address.country }
    city { FFaker::Address.city }
    state { FFaker::AddressUS.state }
    street { FFaker::Address.street_name }
    latitude_from { 30 }
    longitude_from { 60 }
    latitude_to { 40 }
    longitude_to { 70 }
    type { 0 }
  end
end
