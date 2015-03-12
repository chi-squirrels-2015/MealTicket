Rails.application.routes.draw do

  # get "/search" => "restaurants#search"
  get "/search_yelp" => 'restaurants#search_yelp'

  get "/preview_tickets" => "promotions#preview_tickets"

  get "/closest_restaurants" => "restaurants#closest"
  get "/map" => "restaurants#map"

  root "restaurants#map"

  resources :promotions, only: [:new, :create] do
    resources :tickets, only: [:show]
  end

  # Stripe
  resources :purchases, only: [:new, :create]

  get "/dashboard" => "restaurants#dashboard", as: "dashboard"

  # add route for tickets AJAX call in dashboard
  get "/promotion_tickets/:id" => "promotions#promotion_tickets", as: "promotion_tickets"

  get "/login" => 'sessions#new'
  post "/login" => 'sessions#create'
  get "/logout" => 'sessions#destroy'
  get "/signup" => 'restaurants#new'
  post "/restaurants" => 'restaurants#create'
  get "/restaurants/:id" => 'restaurants#show'
end
