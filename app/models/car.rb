class Car < ApplicationRecord
  has_one :payment
  
  validates :status, inclusion: { in: %w(parked checkedout) }
  validates :plate, format: { with: /\A[A-Z]{3}-\d{4}\z/, message: "plate should be format AAA-0000" }
end
