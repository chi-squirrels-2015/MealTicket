class SessionsController < ApplicationController

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.find_by_name(params[:name]).try(:authenticate, params[:password])
  
    if @restaurant
      session[:restaurant_id] = @restaurant.id
      redirect_to dashboard_path
    else
      render login_path
    end
  end

  def destroy
    session.delete(:restaurant_id)
    redirect_to root_path
  end

end
