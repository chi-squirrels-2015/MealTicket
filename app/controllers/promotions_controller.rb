class PromotionsController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @promotions = @restaurant.promotions
  end

  def new
    @promotion = Promotion.new
  end

  def create
  end

  def show
    @promotion = Promotion.find(params[:id])
    @promotion.restaurant = Restaurant.find(params[:restaurant_id])
  end

  def preview_tickets
    promo = promotion_params.to_h
    promo['max_discount'] = promotion_params['max_discount'].to_f / 100
    @promotion = Promotion.new(promo)
    render json: @promotion.preview_tickets
  end

  def promotion_params
    puts params
    params.require(:promotion).permit(:name, :restaurant_id, :min_group_size, :max_group_size, :preferred_group_size, :max_discount, :min_spend, :loss_tolerance)
  end
end
