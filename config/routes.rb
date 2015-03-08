Rails.application.routes.draw do
  get "/search" => "restaurants#search"
  get "/search_yelp" => 'restaurants#search_yelp'

  get "/preview_tickets" => "promotions#preview_tickets"

  # post "/restaurants" => 'restaurants#create'
  # get "/restaurants" => 'restaurants#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root "restaurants#index"

  resources :restaurants, only: [:new, :create, :show] do
    resources :promotions, only: [:index, :new, :create, :show] do
      resources :tickets, only: [:show]
    end

  end

  # Stripe
  resources :charges

  # get 'dashboard', to: 'restaurants#show', as: :dashboard

end
