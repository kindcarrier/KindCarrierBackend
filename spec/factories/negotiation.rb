FactoryBot.define do
  factory :negotiation do
    name { FFaker::Name.name }
    description { 'negotiation_description' }
    service_cost { rand(10..20) }
    owner_id { create(:user).id }
    accepter_id { create(:user).id }

    address_from do
      {
        country: FFaker::Address.country,
        city: FFaker::Address.city,
        state: FFaker::AddressUS.state,
        street: FFaker::Address.street_name,
        latitude: 90,
        longitude: 180
      }
    end
    address_to do
      {
        country: FFaker::Address.country,
        city: FFaker::Address.city,
        state: FFaker::AddressUS.state,
        street: FFaker::Address.street_name,
        latitude: 90,
        longitude: 180
      }
    end
    type { 0 }
  end
end
