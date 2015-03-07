# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Restaurant.create!(name: "Bobs Burgers", cuisine: "Greasy Spoon", display_phone: "847-769-2416", address: "1526 W Cullom", zipcode: "60613", yelp_id: "bobs-burgers-fake-place")
Restaurant.create!(name: "Krusty Krab", cuisine: "Burgers", display_phone: "213-447-6726", address: "68 Sharon Street", zipcode: "11211", yelp_id: "krusty-krab-fake-place")
Restaurant.create!(name: "Jack Rabbit Slim's", cuisine: "'Murican", display_phone: "213-380-6390", address: "748 S. Kingsley", zipcode: "90019", yelp_id: "jack-rabbit-slims-fake-place")

restaurants = Restaurant.all
5.times do
  Promotion.create(name: "Neighborhood Special", restaurant_id: restaurants.sample.id, min_group_size: "2", max_group_size: "8", preferred_group_size: "4", max_discount: "0.15", min_spend: "20", loss_tolerance: "200")
end

5.times do
  Promotion.create(name: "Neighborhood Special", restaurant_id: restaurants.sample.id, min_group_size: "4", max_group_size: "10", preferred_group_size: "4", max_discount: "0.20", min_spend: "30", loss_tolerance: "500")
end

5.times do
  Promotion.create(name: "Neighborhood Special", restaurant_id: restaurants.sample.id, min_group_size: "6", max_group_size: "12", preferred_group_size: "6", max_discount: "0.25", min_spend: "40", loss_tolerance: "1000")
end
