FactoryBot.define do
  factory :message do
    association :user
    association :deal
    text { 'text of message' }
  end
end
