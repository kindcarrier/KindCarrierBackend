FactoryBot.define do
  factory :address do
    country { FFaker::Address.country }
    state { FFaker::AddressUS.state }
    city { FFaker::Address.city }
    street { FFaker::Address.street_name }
    latitude { rand(30..80) }
    longitude { rand(40..60) }
  end
end
