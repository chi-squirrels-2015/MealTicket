class TicketsController < ApplicationController
  def index
    @tickets = Ticket.where(active: true)
  end

  def show
    @ticket = Ticket.find(params[:id]).where(:ticket => {:active => true})
  end
end
