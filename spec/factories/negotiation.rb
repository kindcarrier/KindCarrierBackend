FactoryBot.define do
  factory :negotiation do
    owner { FactoryBot.create(:user) }
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
        latitude: rand(0..90),
        longitude: rand(0..180)
      }
    end
    address_to do
      {
        country: FFaker::Address.country,
        city: FFaker::Address.city,
        state: FFaker::AddressUS.state,
        street: FFaker::Address.street_name,
        latitude: rand(0..90),
        longitude: rand(0..180)
      }
    end
    type { 0 }
  end
end
