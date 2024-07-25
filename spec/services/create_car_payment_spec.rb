require 'rails_helper'

RSpec.describe CreateCarPayment do
  describe '#perform' do
    let(:car) { create(:car) }
    subject { described_class.new(car) }

    context 'when car does not have a payment' do
      it 'creates a payment' do
        expect { subject.perform }.to change { Payment.count }.by(1)
      end
    end

    context 'when car already has a payment' do
      before { create(:payment, car: car) }

      it 'raises an error' do
        expect { subject.perform }.to raise_error('Car already has a payment')
      end
    end

    context 'when payment is created' do
      before { subject.perform }

      it 'creates a payment with the correct car_id' do
        expect(Payment.last.car_id).to eq(car.id)
      end

      it 'creates a payment with the correct amount' do
        expect(Payment.last.amount).to eq(100)
      end
    end
  end
end