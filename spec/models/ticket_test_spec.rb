require 'rails_helper'

describe Ticket do
  describe 'Deactivate' do
    let!(:ticket) {Ticket.new(promotion_id: 1, discount: 0.1, min_total_spend: 200, group_size: 4, active: true, ticket_price: 50, loss_per_ticket: 150)}

    it "should be active when created" do
      expect(ticket.active).to be (true)
    end
    it "should not be active when deactivated" do
      ticket.deactivate!
      expect(ticket.active).to be (false)
    end
  end

end
