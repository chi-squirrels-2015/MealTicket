class Purchase < ActiveRecord::Base
  belongs_to :ticket

  after_create :check_current_tickets

  def create_confirmation_id
    self.confirmation_id = SecureRandom.hex(n=9)
    self.save
  end

  def check_current_tickets
  end
end
