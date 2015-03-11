class RestaurantsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  ####################
  #### ADMIN SIDE ####
  ####################

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

  def create
    puts restaurant_params
    @restaurant = Restaurant.create(restaurant_params)
    @restaurant.owner_id = current_owner.id
    @restaurant.save
    redirect_to dashboard_path
  end

  def dashboard
    @restaurant = Restaurant.find_by_owner_id(current_owner.id)
  end


  #####################
  #### PATRON SIDE ####
  #####################

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def closest
    closest = Restaurant.near([params[:lat], params[:lng]], 2).joins(:promotions).where(:promotions => {:active => true})
    geojson = closest.map(&:to_geoJSON)

    render json: geojson
  end

  def map
  end

  private

  def restaurant_params
    params.permit(:yelp_id, :name, :display_phone, :address, :zipcode, :cuisine)
  end
end
