class PurchasesController < ApplicationController
  def new
    @ticket = Ticket.find(params[:purchase][:ticket_id])
    @purchase = Purchase.new
  end

  def create
    @view_model = PurchaseCreateViewModel.new(purchase_params, params[:stripeToken])
    if @view_model.ticket_active?
      if @view_model.within_budget?
        @view_model.deactivate_ticket!
      else
        @view_model.finalize_purchase!
        render "purchases/receipt"
      end
    else
      flash[:error] = "Sorry, this MealTicket is no longer available for purchase."
      redirect_to restaurant_path(@view_model.restaurant)
    end

    rescue Stripe::CardError => stripe_error

    if stripe_error.message
      flash[:error] = stripe_error.message
      render :new
    end
  end


  private

  def purchase_params
    params.require(:purchase).permit(:purchaser_name, :phone_number, :email, :ticket_id)
  end

end
