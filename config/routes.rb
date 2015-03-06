Rails.application.routes.draw do

  root "restaurants#index"

  resources :restaurants, only: [:new, :create] do
    resources :promotions, only: [:index, :new, :create, :show] do
      resources :tickets, only: [:show]
    end

  end

  get 'dashboard', to: 'restaurants#show', as: :dashboard

end
