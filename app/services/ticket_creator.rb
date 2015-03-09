class TicketCreator
  attr_reader :promotion
  def initialize(promotion)
    @promotion = promotion
  end

  def generate_tickets
    unless available_budget
      promotion.available_budget = promotion.loss_tolerance
      promotion.save
    end

    (min_group_size..max_group_size).each_with_index do |group_size, index|
      ticket_params = {}
      ticket_params[:group_size]      = group_size
      ticket_params[:min_total_spend] = min_spend * group_size
      ticket_params[:discount]        = calculate_discount(group_size, index)
      ticket_params[:loss_per_ticket] = ticket_params[:min_total_spend] * ticket_params[:discount]
      ticket_params[:ticket_price]    = ticket_params[:min_total_spend] - (ticket_params[:min_total_spend] * ticket_params[:discount])

      promotion.tickets.create(ticket_params)
    end

  end
end
