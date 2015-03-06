class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:yelp_id, :name, :display_phone, :address, :zipcode, :cuisine)
  end
end