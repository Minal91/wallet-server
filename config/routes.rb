Rails.application.routes.draw do
  get 'transactions/history'
  devise_for :users, sign_out_via: [:get, :delete]

  root "home#index"

  get "transactions/history", to: "transactions#history", as: :transaction_history

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
