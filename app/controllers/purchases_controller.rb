class PurchasesController < ApplicationController
  def new
    # puts params
    # @ticket = nil
  end

  def create
    @promotion = params[:purchase][:promotion]
    @amount = params[:purchase][:ticket_price].to_i * 100
    puts @amount

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
