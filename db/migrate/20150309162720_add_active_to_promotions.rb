class AddActiveToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :active, :boolean, default: true
  end
end
