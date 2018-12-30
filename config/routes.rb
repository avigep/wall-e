Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'screens/transactions'
      resources :wallets do
        resources :transactions, only: [:index]
      end
    end
  end
end
