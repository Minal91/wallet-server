Rails.application.routes.draw do
  resources :transactions
  devise_for :users, sign_out_via: [:get, :delete]

  root "home#index"
  resources :balance, only: [] do
    collection do
      get :details
    end
  end

  namespace :api do
    namespace :v1 do
      resources :transactions, only: [:index, :show, :create, :update]
      resources :users, only: [:index, :show]
      resources :balance, only: [:index]
    end
  end 
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
