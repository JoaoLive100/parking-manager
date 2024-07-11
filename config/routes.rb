Rails.application.routes.draw do

  # ----------------- CARS -----------------
  # GET /cars/all (all cars)
  get 'cars/all', to: 'cars#all'

  # GET /cars/parked (all parked cars)
  get 'cars/parked', to: 'cars#parked'

  # GET /cars/checkedout (all checkedout cars)
  get 'cars/checkedout', to: 'cars#checkedout'

  resources :cars

  get "up" => "rails/health#show", as: :rails_health_check
end
