Rails.application.routes.draw do

  # ----------------- CARS -----------------
  # GET /cars/all (all cars)
  get 'cars/all', to: 'cars#all'

  # GET /cars/parked (all parked cars)
  get 'cars/parked', to: 'cars#parked'

  # GET /cars/checkedout (all checkedout cars)
  get 'cars/checkedout', to: 'cars#checkedout'

  resources :cars

  # ----------------- PAYMENTS -----------------
  # GET /payments/all (all payments)
  get 'payments/all', to: 'payments#all'

  # GET /payments/pending (all pending payments)
  get 'payments/pending', to: 'payments#pending'

  # GET /payments/paid (all paid payments)
  get 'payments/paid', to: 'payments#paid'

  resources :payments

  get "up" => "rails/health#show", as: :rails_health_check
end