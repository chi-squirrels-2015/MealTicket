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
      end
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
