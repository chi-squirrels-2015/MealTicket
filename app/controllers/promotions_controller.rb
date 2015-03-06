class PromotionsController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @promotions = @restaurant.promotions
  end

  def new
    @promotion = Promotion.new
  end

  def show
    @promotion = Promotion.find(params[:id])
    @promotion.restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to @promotion
    else
      render :new
    end
  end

  def promotion_params
    params.require(:deal).permit(:name, :restaurant_id, :min_group_size, :max_group_size, :preferred_group_size, :max_discount, :min_spend, :loss_tolerance)
  end
end
