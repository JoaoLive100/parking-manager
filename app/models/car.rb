class Car < ApplicationRecord
  has_one :payment
  
  validates :status, inclusion: { in: %w(parked checkedout) }
end
