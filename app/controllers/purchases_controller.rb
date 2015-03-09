class PurchasesController < ApplicationController
  def new
    @ticket = Ticket.find(params[:purchase][:ticket_id])
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)

    @ticket = Ticket.find(params[:purchase][:ticket_id])
    @promotion = @ticket.promotion
    @amount = (@ticket.ticket_price).to_i * 100

    if @purchase.ticket.active
      if @purchase.ticket.promotion.available_budget < @ticket.loss_per_ticket
        @purchase.ticket.update(active: false)
        @purchase.errors.full_message
      else
        customer = Stripe::Customer.create(
          :email => 'example@stripe.com',
          :card  => params[:stripeToken]
        )

        purchase = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount,
          :description => @promotion,
          :currency    => 'usd'
        )

        @purchase.create_confirmation_id
        @purchase.purchaser_name = @purchaser_name
        @purchase.phone_number = @phone_number
        @purchase.save
      end
    else
      @purchase.errors.full_message
    end

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to purchases_path
  end


  private

  def purchase_params
    params.require(:purchase).permit(:purchaser_name, :phone_number, :ticket_id)
  end

end
