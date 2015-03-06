class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.belongs_to :restaurant

      t.string :name

      t.integer :min_group_size
      t.integer :max_group_size
      t.integer :preferred_group_size
      t.integer :loss_tolerance

      t.decimal :min_spend
      t.decimal :max_discount

      t.timestamps
    end
  end
end
