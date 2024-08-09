# frozen_string_literal: true

RSpec.describe CarsController, type: :controller do
  describe 'GET #all' do
    it 'returns all cars' do
      get :all
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(Car.all.size)
    end
  end

  describe 'GET #parked' do
    let (:car) {create(:car, status: 'parked')}

    it 'returns all parked cars' do
      get :parked
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(Car.where(status: 'parked').size)
    end
  end

  describe 'GET #checkedout' do
    let (:car) {create(:car, status: 'checkedout')}

    it 'returns all checkedout cars' do
      get :checkedout
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(Car.where(status: 'checkedout').size)
    end
  end

  describe 'GET #show' do
    it 'returns a car by id' do
      car = Car.first
      get :show, params: { id: car.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['id']).to eq(car.id)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a car' do
        expect {
          post :create, params: { car: attributes_for(:car) }
        }.to change(Car, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      it 'returns error if car is not saved' do
        expect {
          post :create, params: { car: attributes_for(:car, plate: nil) }
        }.to change(Car, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let (:car) {create(:car)}
      it 'updates a car' do
        puts car.inspect
        put :update, params: { id: car.id, car: { plate: "ABC-1234", checkin: Time.now, checkout: Time.now, status: "checkedout" } }
        car.reload
        puts car.inspect
        # expect(response).to have_http_status(:ok)
        # puts JSON.parse(response.body)['data'].inspect
        # expect(JSON.parse(response.body)['data']['plate']).to eq('ABC-123')
      end
    end

    context 'with invalid attributes' do
      it 'returns error if car is not updated' do
        car = Car.first
        put :update, params: { id: car.id, car: { plate: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
  let!(:car) { create(:car) }
    it 'deletes a car' do
      expect {
        delete :destroy, params: { id: car.id }
      }.to change(Car, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end