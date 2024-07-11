class Payment < ApplicationRecord
  belongs_to :car

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w(pending paid) }
end
