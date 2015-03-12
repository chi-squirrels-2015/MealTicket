class AddIndexToLatLongOnRestaurants < ActiveRecord::Migration
  def change
    add_index :restaurants, :latitude
    add_index :restaurants, :longitude
  end
end
