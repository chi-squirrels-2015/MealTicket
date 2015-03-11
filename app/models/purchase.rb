class Purchase < ActiveRecord::Base
  belongs_to :ticket

  validates :purchaser_name, presence: true
  validates :phone_number, presence: true

  after_create :check_current_tickets

  def create_confirmation_id
    self.confirmation_id = SecureRandom.hex(n=3)
  end

  def check_current_tickets
    loss = ticket.loss_per_ticket
    self.ticket.promotion.update_available_budget(loss)
    self.ticket.promotion.update_tickets
  end

  def confirm!
    self.create_confirmation_id
    self.save
  end
end
