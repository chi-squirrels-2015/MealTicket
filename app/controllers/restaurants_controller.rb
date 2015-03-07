class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    render json: @restaurants
  end

  def search
  end

  def search_yelp
    parameters = { sort: "0", term: params["business-name"], limit: 3, category_filter: "restaurants,bars" }
    render json: Yelp.client.search(params["location"], parameters).businesses
  end

  def new
    @restaurant = Restaurant.new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    redirect_to @restaurant
  end

  private

  def restaurant_params
    params.permit(:yelp_id, :name, :display_phone, :address, :zipcode, :cuisine)
  end
end
