class TicketsController < ApplicationController
  def index
    @tickets = Ticket.where(active: true)
  end

  def show
    @ticket = Ticket.find(params[:id])
  end
end
