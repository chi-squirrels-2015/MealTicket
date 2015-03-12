class PromotionsController < ApplicationController
  def new
    unless current_restaurant
      redirect_to root_path
    end
    @promotion = Promotion.new
  end

  def create
    promo = promotion_params.to_h
    promo['max_discount'] = promotion_params['max_discount'].to_f / 100
    @promotion = current_restaurant.promotions.build(promo)

    if @promotion.save
      redirect_to dashboard_path
    else
      @errors = @promotion.errors
      render :new
    end
  end

  def show
    @promotion = Promotion.find(params[:id])
  end

  def preview_tickets
    unless current_restaurant
      redirect_to root_path
    end
    promo = promotion_params.to_h
    promo['max_discount'] = promotion_params['max_discount'].to_f / 100
    @promotion = Promotion.new(promo)
    render json: @promotion.preview_tickets
  end

  def promotion_tickets
    @promotion = Promotion.find(params[:id])
    @purchases = @promotion.purchases
    render :partial =>  "promotions/ticket", locals: {promotion: @promotion, purchases: @purchases}
  end

  def promotion_params
    params.require(:promotion).permit(:name, :valid_on, :restaurant_id, :min_group_size, :max_group_size, :preferred_group_size, :max_discount, :min_spend, :loss_tolerance)
  end
end
