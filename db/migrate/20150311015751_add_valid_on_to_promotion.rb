class AddValidOnToPromotion < ActiveRecord::Migration
  def change
    add_column :promotions, :valid_on, :date
  end
end
