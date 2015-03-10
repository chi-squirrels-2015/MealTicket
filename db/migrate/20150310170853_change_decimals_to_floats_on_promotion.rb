class ChangeDecimalsToFloatsOnPromotion < ActiveRecord::Migration
  def change
    change_column :promotions, :loss_tolerance, :float
    change_column :promotions, :available_budget, :float
    change_column :promotions, :min_spend, :float
    change_column :promotions, :max_discount, :float
  end
end
