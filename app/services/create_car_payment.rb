class CreateCarPayment
    def initialize(car)
        @car = car
        @car_id = car.id
    end

    def perform
        validate!
        create_payment
    end

    private

    def create_payment
        Payment.create({
            car_id: @car_id,
            amount: 100
        })
    end

    def validate!
        raise 'Car already has a payment' if @car.payment.present?
    end
end