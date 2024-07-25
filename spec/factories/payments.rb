FactoryBot.define do
  factory :payment do
    amount { 100 }
    status { 'pending' }
    paid_at { nil }
    car
  end
end