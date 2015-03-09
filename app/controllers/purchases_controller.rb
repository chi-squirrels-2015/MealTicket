require 'pry'

class PurchasesController < ApplicationController
  def new
    @ticket = Ticket.find(params[:purchase][:ticket_id])
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)

    @ticket = Ticket.find(params[:purchase][:ticket_id])
    @promotion = @ticket.promotion
    @amount = ((@ticket.ticket_price) * 100).to_i

    if @purchase.ticket.active
      if @purchase.ticket.promotion.available_budget < @ticket.loss_per_ticket
        @purchase.ticket.update(active: false)
        @purchase.errors.full_message
      else
        customer = Customer.new({
          email: params[:purchase][:email],
          card: params[:stripeToken],
        })
        customer.create_in_stripe!
        customer.charge!(@amount, description: @promotion)
        @purchase.confirm!
        customer.send_confirmation_message!(@purchase)

        # customer = Stripe::Customer.create(
        #   :email => params[:purchase][:email],
        #   :card  => params[:stripeToken]
        # )

        # purchase = Stripe::Charge.create(
        #   :customer    => customer.id,
        #   :amount      => @amount,
        #   :description => @promotion,
        #   :currency    => 'usd'
        # )

        # @purchase.create_confirmation_id
        # @purchase.save

        # client = Twilio::REST::Client.new
        # client.messages.create({
        #   from: "+13123131171",
        #   to:   @purchase.phone_number,
        #   body: "Hey #{@purchase.purchaser_name},\nThanks for choosing MealTicket for #{@purchase.ticket.promotion.restaurant.name} for a group of #{@purchase.ticket.group_size}. Your confirmation number is: #{@purchase.confirmation_id}. Enjoy your meal!"
        # })

        render "purchases/create"
      end
    else
      @purchase.errors.full_message
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
    params.require(:purchase).permit(:purchaser_name, :phone_number, :ticket_id, :email)
  end

end
