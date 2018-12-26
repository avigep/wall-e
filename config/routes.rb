Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :wallets do
        resources :transactions, only: [:index]
      end
    end
  end
end
