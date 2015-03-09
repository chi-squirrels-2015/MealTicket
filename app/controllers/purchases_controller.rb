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
        customer = Stripe::Customer.create(
          :email => params[:purchase][:email]
          :card  => params[:stripeToken]
        )

        purchase = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount,
          :description => @promotion,
          :currency    => 'usd'
        )

        @purchase.create_confirmation_id
        @purchase.purchaser_name = params[:purchase][:purchaser_name]
        @purchase.phone_number = params[:purchase][:phone_number]
        @purchase.save
      end
    else
      @purchase.errors.full_message
    end

    rescue Stripe::CardError => stripe_error

    if stripe_error.message
      flash[:error] = stripe_error.message
      puts stripe_error
      render :new
    else
      @name = @purchase.purchaser_name
      @phone = @purchase.phone_number
      render "purchases/receipt"
    end

    # redirect_to purchases_path
  end


  private

  def purchase_params
    params.require(:purchase).permit(:purchaser_name, :phone_number, :ticket_id, :email)
  end

end
