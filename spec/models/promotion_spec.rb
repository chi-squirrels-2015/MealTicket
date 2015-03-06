require 'rails_helper'

describe Promotion do
  describe "Validations" do
    let(:promotion) { Promotion.create() }

    xit "requires a restaurant_id"

    it "requires a name" do
      expect(promotion.errors).to include(:name)
    end

    it "requires a minimum group size" do
      expect(promotion.errors).to include(:min_group_size)
    end

    it "requires a maximum group size" do
      expect(promotion.errors).to include(:max_group_size)
    end

    it "requires a minimum spend" do
      expect(promotion.errors).to include(:min_spend)
    end

    it "requires a loss tolerance" do
      expect(promotion.errors).to include(:loss_tolerance)
    end

    it "requires a maximum discount" do
      expect(promotion.errors).to include(:max_discount)
    end

    it "requires a preferred group size" do
      expect(promotion.errors).to include(:preferred_group_size)
    end
  end
end