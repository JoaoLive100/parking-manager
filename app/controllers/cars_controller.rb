class CarsController < ApplicationController

    #GET /cars/all (all cars)
    def all
        @cars = Car.all
        render json: {status: 'SUCCESS', message: 'Loaded all cars', data: @cars}, status: :ok
    end

    #GET /cars/parked (all parked cars)
    def parked
        @cars = Car.where(status: 'parked')
        render json: {status: 'SUCCESS', message: 'Loaded all parked cars', data: @cars}, status: :ok
    end

    #GET /cars/checkedout (all checkedout cars)
    def checkedout
        @cars = Car.where(status: 'checkedout')
        render json: {status: 'SUCCESS', message: 'Loaded all checkedout cars', data: @cars}, status: :ok
    end

    #GET /cars/:id (car by id)
    def show
        @car = Car.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded car', data: @car}, status: :ok
    end

    #POST /cars (create a car)
    def create
        @car = Car.new(car_params)
        if @car.save
            
            @payment = CreateCarPayment.new(@car)
            @payment.perform

            render json: {status: 'SUCCESS', message: 'Saved car', data: @car}, status: :ok
        else
            render json: {status: 'ERROR', message: 'Car not saved', data: @car.errors}, status: :unprocessable_entity
        end
    end

    #PUT /cars/:id (update a car)
    def update
        @car = Car.find(params[:id])
        if @car.update(car_params)
            render json: {status: 'SUCCESS', message: 'Updated car', data: @car}, status: :ok
        else
            render json: {status: 'ERROR', message: 'Car not updated', data: @car.errors}, status: :unprocessable_entity
        end
    end

    #DELETE /cars/:id (delete a car)
    def destroy
        ActiveRecord::Base.transaction do
            @car = Car.find(params[:id])

            @payment = DeleteCarPayment.new(@car)
            @payment.perform
            
            @car.destroy
            render json: {status: 'SUCCESS', message: 'Deleted car', data: @car}, status: :ok
        end
    end

    private

    def car_params
        params.require(:car).permit(:plate, :checkin, :checkout, :status)
    end
end
