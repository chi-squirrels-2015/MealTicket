class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    render json: @restaurants
  end

  def search
  end

  def search_yelp
    parameters = { sort: "0", term: params["business-name"], limit: 3 }
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
    redirect_to restaurant_path(@restaurant)
    # redirect_to dashboard_path(@restaurant)
  end

  private

  def restaurant_params
    params.permit(:yelp_id, :name, :display_phone, :address, :zipcode, :cuisine)
  end
end
