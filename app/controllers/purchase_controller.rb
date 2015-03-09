class PurchaseController < ApplicationController
  def new
    @ticket = Ticket.find(params[:ticket_id])
    @promotion = @ticket.promotion
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.promotion = @promotion
    @purchase.ticket = @ticket

    if @purchase.ticket.active
      if @purchase.ticket.promotion.available_budget < @ticket.loss_per_ticket
        @purchase.ticket.update(active: false)
        @purchase.errors.full_message # "This promotion has expired."
      else
        @purchase.create_confirmation_id
        @promotion = params[:purchase][:promotion]
        @amount = params[:purchase][:ticket_price].to_i * 100

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
        @purchase.save
        # sending text confirmation
      end
    else
      @purchase.errors.full_message # "This promotion has expired."
    end
  end


  private

  def purchase_params
    params.require(:purchase).permit(:purchaser_name. :phone_number)
  end

end
