class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :cuisine
      t.string :phone_number
      t.string :address
      t.integer :zip_code
      t.string :location
      t.timestamps null: false
    end
  end
end
