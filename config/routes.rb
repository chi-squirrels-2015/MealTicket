Rails.application.routes.draw do

  get "/search" => "restaurants#search"
  get "/search_yelp" => 'restaurants#search_yelp'

  get "/preview_tickets" => "promotions#preview_tickets"

  get "/closest_restaurants" => "restaurants#closest"
  get "/map" => "restaurants#map"


  # post "/restaurants" => 'restaurants#create'
  # get "/restaurants" => 'restaurants#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root "restaurants#map"

  resources :restaurants, only: [:new, :create, :show] do
    resources :promotions, only: [:index, :new, :create, :show] do
      resources :tickets, only: [:show]
    end

  end

  # resources :tickets, only: [:index, :show]

  # Stripe
  resources :purchases, only: [:new, :create]

  resources :patrons, only: [:index, :show] do
      resources :promotions, only: [:index, :show]
  end

  get "/dashboard" => "restaurants#dashboard", as: "dashboard"

  # add route for tickets AJAX call in dashboard
  get "/promotion_tickets/:id" => "promotions#promotion_tickets", as: "promotion_tickets"

  get "/login" => 'sessions#new'
  post "/login" => 'sessions#create'
  get "/logout" => 'sessions#destroy'

end
