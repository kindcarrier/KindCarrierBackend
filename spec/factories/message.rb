FactoryBot.define do
  factory :message do
    association :user
    association :negotiation
    text { 'text of message' }
  end
end
