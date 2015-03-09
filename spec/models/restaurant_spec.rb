require 'rails_helper'

describe Restaurant do
  describe "validations" do
    let!(:restaurant) { Restaurant.create(restaurant_params) }
    it "requires a unique yelp id" do
      restaurant2 = Restaurant.new(restaurant_params)
      restaurant2.yelp_id = "chicago"
      restaurant2.save
      expect(restaurant2.errors).to include(:yelp_id)
    end

    it "requires a name" do
      restaurant.name = ""
      restaurant.save
      expect(restaurant.errors).to include(:name)
    end

    it "requires an address" do
      restaurant.address = ""
      restaurant.save
      expect(restaurant.errors).to include(:address)
    end

    it "requires a zipcode" do
      restaurant.zipcode = ""
      restaurant.save
      expect(restaurant.errors).to include(:zipcode)
    end

    it "requires a phone number" do
      restaurant.display_phone = ""
      restaurant.save
      expect(restaurant.errors).to include(:display_phone)
    end

    it "requires a cuisine" do
      restaurant.cuisine = ""
      restaurant.save
      expect(restaurant.errors).to include(:cuisine)
    end
  end
end

def restaurant_params
  { yelp_id: "chicago",
    name: "Bob's Burgers",
    address: "351 W Hubbard Street",
    zipcode: "60654",
    display_phone: "123-456-7890",
    cuisine: "Ruby" }
end