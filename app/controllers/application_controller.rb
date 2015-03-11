class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_restaurant

  def current_restaurant
    # require 'pry'; binding.pry
    @_restaurant ||= Restaurant.find(session[:restaurant_id]) if session[:restaurant_id]
  end

  protect_from_forgery with: :null_session
end
