Rails.application.routes.draw do
  get "/search" => "restaurants#search"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root "restaurants#index"

  resources :restaurants, only: [:new, :create] do
    resources :promotions, only: [:index, :new, :create, :show] do
      resources :tickets, only: [:show]
    end

  end

  get 'dashboard', to: 'restaurants#show', as: :dashboard

end
