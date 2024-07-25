FactoryBot.define do
  factory :car do
    plate { Faker::Vehicle.license_plate }
    checkin { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    checkout { Faker::Time.between(from: DateTime.now, to: DateTime.now + 1) }
    status { 'parked' }
  end
end