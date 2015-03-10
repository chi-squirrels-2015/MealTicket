require 'rails_helper'

describe Promotion do
  let(:promotion) { Promotion.new(promotion_params) }

  describe "Validations" do
    it "requires a restaurant_id" do
      promotion.restaurant_id = nil
      promotion.save
      expect(promotion.errors).to include(:restaurant_id)
    end

    it "requires a name" do
      promotion.name = nil
      promotion.save
      expect(promotion.errors).to include(:name)
    end

    it "requires a minimum group size" do
      promotion.min_group_size = nil
      promotion.save
      expect(promotion.errors).to include(:min_group_size)
    end

    it "requires a maximum group size" do
      promotion.max_group_size = nil
      promotion.save
      expect(promotion.errors).to include(:max_group_size)
    end

    it "requires a minimum spend" do
      promotion.min_spend = nil
      promotion.save
      expect(promotion.errors).to include(:min_spend)
    end

    it "requires a loss tolerance" do
      promotion.loss_tolerance = nil
      promotion.save
      expect(promotion.errors).to include(:loss_tolerance)
    end

    it "requires a maximum discount" do
      promotion.max_discount = nil
      promotion.save
      expect(promotion.errors).to include(:max_discount)
    end

    it "requires a preferred group size" do
      promotion.preferred_group_size = nil
      promotion.save
      expect(promotion.errors).to include(:preferred_group_size)
    end
  end

  describe '::minimum_discount' do
    it "returns a decimal value" do
      expect(Promotion.minimum_discount).to be_a(Float)
    end
  end

  describe '#generate_tickets' do
    it "generates tickets" do
      expect(promotion.tickets).to receive(:create).exactly(3).times
      promotion.generate_tickets
    end
  end

  describe '#preview_tickets' do
    let(:ticket) { promotion.preview_tickets.first }

    it "returns an array of hashes" do
      expect(promotion.preview_tickets).to all(be_a Hash)
    end

    it "contains the params of a ticket" do
      expect(ticket.keys).to(
        eq([:group_size, :min_total_spend, :discount, :loss_per_ticket, :ticket_price, :active]))
    end

    it "has the proper discount" do
      expect(ticket[:discount]).to eq(0.12)
    end

    it "has the proper minimum total spend" do
      expect(ticket[:min_total_spend]).to eq(40)
    end

    it "has the proper group size" do
      expect(ticket[:group_size]).to eq(2)
    end

    it "has the proper loss per ticket" do
      expect(ticket[:loss_per_ticket]).to eq(4.8)
    end

    it "has the proper ticket price" do
      expect(ticket[:ticket_price]).to eq(35.2)
    end
  end
end

def promotion_params
  {
    name: "Test",
    min_group_size: 2,
    max_group_size: 4,
    preferred_group_size: 2,
    min_spend: 20,
    loss_tolerance: 100,
    max_discount: 0.20,
    restaurant_id: 1
  }
end