require 'rails_helper'
require 'spec_helper'

describe Purchase do
  before (:all) do
    promo_params = {
                     name: "PromoTest",
                     min_group_size: 2,
                     max_group_size: 8,
                     preferred_group_size: 4,
                     loss_tolerance: 339,
                     available_budget: 2,
                     min_spend: 10,
                     max_discount: 0.23
                   }
    @promotion = Promotion.create(promo_params)

    ticket_params = {
                      discount: 0.1,
                      min_total_spend: 20,
                      group_size: 2,
                      active: true,
                      loss_per_ticket: 2,
                      promotion: @promotion
                    }
    @ticket = Ticket.create(ticket_params)

    purchase_params = {
                        purchaser_name: "Jane",
                        phone_number: "213-447-6726",
                        ticket: @ticket
                      }
    @purchase = Purchase.create(purchase_params)
  end

  describe "Validations" do
    let(:faulty_purchase) { Purchase.new() }

    it "requires a phone number" do
      expect(faulty_purchase.id).to be(nil)
    end

    it "requires a purchaser name" do
      expect(faulty_purchase.id).to be(nil)
    end

    it "validates purchases with proper information" do
      expect(@purchase.id).to_not be(nil)
    end
  end

  describe "#create_confirmation_id" do
    it "creates a confirmation id that is 18 characters in length" do
      expect(@purchase.create_confirmation_id.length).to be(18)
    end

    it "creates a unique confirmation id" do
      purchase_params = {
                          purchaser_name: "Matthew Gray",
                          phone_number: "222-555-8888",
                          ticket: @ticket
                        }
      second_purchase = Purchase.create(purchase_params)
      second_id = second_purchase.create_confirmation_id
      expect(@purchase.create_confirmation_id).to_not eq(second_id)
    end
  end

  describe "#check_current_tickets" do
    it "returns information about the ticket being purchased" do
      tickets_array = @purchase.check_current_tickets
      tickets_array.each do |ticket|
        expect(ticket).to be(true)
      end
    end
  end

  describe "#confirm!" do
    it "updates purchase with a confirmation number" do
      @purchase.confirm!
      expect(@purchase.confirmation_id).to_not be(nil)
    end
  end

end