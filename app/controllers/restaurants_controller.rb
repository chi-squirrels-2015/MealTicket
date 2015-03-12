class RestaurantsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  ####################
  #### ADMIN SIDE ####
  ####################

  def search_yelp
    parameters = { sort: "0", term: params["business-name"], limit: 3, category_filter: "restaurants,bars" }
    render json: Yelp.client.search(params["location"], parameters).businesses
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      session[:restaurant_id] = @restaurant.id
      redirect_to dashboard_path
    else
      flash[:error] = "The Restaurant could not be saved"
      render :new
    end
  end

  def dashboard
    unless current_restaurant
      redirect_to root_path
    end
  end


  #####################
  #### PATRON SIDE ####
  #####################

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def closest
    geojson = Restaurant.near([params[:lat], params[:lng]], 2).map(&:to_geoJSON)

    geojson.each do |restaurant|
      yelp = Yelp.client.business(restaurant[:features][0][:properties][:yelp_id])
      restaurant[:features][0][:properties][:rating_url]   = yelp.rating_img_url_small
      restaurant[:features][0][:properties][:review_count] = yelp.review_count
    end
    render json: geojson
  end

  def map
  end

  private

  def restaurant_params
    params.permit(:yelp_id, :email, :name, :password, :display_phone, :address, :zipcode, :cuisine)
  end
end
