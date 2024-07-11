class DeleteCarPayment
    def initialize(car)
        @car = car
        @car_id = car.id
    end

    def perform
        delete_payment
    end

    private

    def delete_payment
        Payment.destroy(@car_id)
    end
end