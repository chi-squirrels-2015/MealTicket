class PurchaseCreateViewModel

  attr_reader :purchase, :customer

  delegate :ticket, to: :purchase

  def initialize(purchase_params, stripe_token)
    @purchase = Purchase.new(purchase_params)
    @ticket = Ticket.find_by(id: purchase_params[:ticket_id])
    @stripe_token = stripe_token
    @purchase.ticket = @ticket
  end

  def finalize_purchase!
    customer.finalize_purchase(purchase, amount, promotion)
  end

  def customer
    @customer ||= Customer.new({
      email: purchase.email,
      card: @stripe_token,
      })
  end

  def deactivate_ticket!
    ticket.deactivate!
  end

  def within_budget?
    promotion.available_budget < ticket.loss_per_ticket
  end

  def ticket_active?
    ticket.active
  end

  def restaurant
    promotion.restaurant
  end

  def promotion
    @promotion ||= ticket.promotion
  end

  def amount
    @amount ||= (ticket.ticket_price * 100).to_i
  end

  def purchaser_name
    purchase.purchaser_name
  end

  def confirmation_id
    purchase.confirmation_id
  end
end