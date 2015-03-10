class PurchasesController < ApplicationController
  def new
    @ticket = Ticket.find(params[:purchase][:ticket_id])
    @purchase = Purchase.new
  end

  def create
  end

  private

  def purchase_params
    params.require(:purchase).permit(:purchaser_name, :phone_number, :ticket_id, :email)
  end

end
