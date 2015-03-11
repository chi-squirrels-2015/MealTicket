class AddAuthToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :email, :string
    add_column :restaurants, :password_digest, :string
  end
end
