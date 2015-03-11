class PurchasesController < ApplicationController
  def new
    @ticket = Ticket.find(params[:purchase][:ticket_id])
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @ticket = Ticket.find_by(id: params[:purchase][:ticket_id])

    @purchase.ticket = @ticket

    @promotion = @purchase.ticket.promotion
    @amount = (@purchase.ticket.ticket_price * 100).to_i

    if @ticket.active
      if @promotion.available_budget < @ticket.loss_per_ticket
        @ticket.deactivate!
      else
        customer = Customer.new({
          email: params[:purchase][:email],
          card: params[:stripeToken],
        })
        customer.create_in_stripe!
        customer.charge!(@amount, description: @promotion)
        @purchase.confirm!
        # sleep 0.1 # sometimes firing to fast?
        customer.send_confirmation_message!(@purchase)
        render "purchases/receipt"
      end
    else
      flash[:error] = "Sorry, this MealTicket is no longer available for purchase."
      redirect_to restaurant_path(@promotion.restaurant)
    end

    rescue Stripe::CardError => stripe_error

    if stripe_error.message
      flash[:error] = stripe_error.message
      puts stripe_error
      render :new
    end
  end


  private

  def purchase_params
    params.require(:purchase).permit(:purchaser_name, :phone_number, :email)
  end

end
