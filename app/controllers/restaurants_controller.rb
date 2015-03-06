class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def search
  end

  def search_yelp
    parameters = { sort: "0", term: params["restaurant"], limit: 3 }
    render json: Yelp.client.search(params["zipcode"], parameters).businesses
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