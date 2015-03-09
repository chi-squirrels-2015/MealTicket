class PurchasesController < ApplicationController
  def new
    @ticket = Ticket.find(params[:ticket_id])
    @promotion = @ticket.promotion
    @purchase = Purchase.new
    puts params
  end

  def create
    @ticket = Ticket.find(params[:purchase][:ticket_id])
    @promotion = @ticket.promotion
    @purchaser_name = params[:purchase][:purchaser_name]
    @phone_number = params[:purchase][:phone_number]
    @amount = (@ticket.ticket_price).to_i * 100

    # @promotion = params[:purchase][:promotion]
    # @amount = params[:purchase][:ticket_price].to_i * 100

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

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to purchases_path
  end
end
