class PromotionsController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @promotions = @restaurant.promotions
  end

  def new
    @promotion = Promotion.new
  end

  def create
    promo = promotion_params.to_h
    promo['max_discount'] = promotion_params['max_discount'].to_f / 100
    @restaurant = Restaurant.find(params[:restaurant_id])
    @promotion = @restaurant.promotions.build(promo)
    
    if @promotion.save
      redirect_to restaurant_path(@restaurant)

    account_sid = 'AC4e7f62423e77cd36e42d12a819296124' 
    auth_token = 'd387d7f38479e494bebd290f29a283df' 

    client = Twilio::REST::Client.new account_sid, auth_token

    client.messages.create({
      from: "+13123131171",
      to:   "+14085940365",
      body: "Hey, you just created a new promotion: #{@promotion.name}!"
      })

    else
      puts @promotion.errors.full_messages
      render :new
    end
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
