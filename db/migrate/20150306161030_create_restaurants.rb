class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :yelp_id
      t.string :name
      t.string :display_phone
      t.string :address
      t.string :zipcode
      t.string :cuisine

      t.timestamps null: false
    end
  end
end
