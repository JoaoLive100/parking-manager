class PaymentsController < ApplicationController

    #GET /payments/all (all payments)
    def all
        @payments = Payment.all
        render json: {status: 'SUCCESS', message: 'Loaded all payments', data: @payments}, status: :ok
    end

    #GET /payments/pending (all pending payments)
    def pending
        @payments = Payment.where(status: 'pending')
        render json: {status: 'SUCCESS', message: 'Loaded all pending payments', data: @payments}, status: :ok
    end

    #GET /payments/paid (all paid payments)
    def paid
        @payments = Payment.where(status: 'paid')
        render json: {status: 'SUCCESS', message: 'Loaded all paid payments', data: @payments}, status: :ok
    end

    #GET /payments/:id (payment by id)
    def show
        @payment = Payment.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded payment', data: @payment}, status: :ok
    end

    #POST /payments (create a payment)
    def create
        @payment = Payment.new(payment_params)
        if @payment.save
            render json: {status: 'SUCCESS', message: 'Saved payment', data: @payment}, status: :ok
        else
            render json: {status: 'ERROR', message: 'Payment not saved', data: @payment.errors}, status: :unprocessable_entity
        end
    end

    #PUT /payments/:id (update a payment)
    def update
        @payment = Payment.find(params[:id])
        if @payment.update(payment_params)
            render json: {status: 'SUCCESS', message: 'Updated payment', data: @payment}, status: :ok
        else
            render json: {status: 'ERROR', message: 'Payment not updated', data: @payment.errors}, status: :unprocessable_entity
        end
    end

    #DELETE /payments/:id (delete a payment)
    def destroy
        @payment = Payment.find(params[:id])
        @payment.destroy
        render json: {status: 'SUCCESS', message: 'Deleted payment', data: @payment}, status: :ok
    end

    private

    def payment_params
        params.require(:payment).permit(:car_id, :amount, :status, :paid_at)
    end
end
