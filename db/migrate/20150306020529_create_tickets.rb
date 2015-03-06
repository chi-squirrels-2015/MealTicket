class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.belongs_to :promotion
      t.decimal :discount
      t.decimal :min_total_spend
      t.integer :group_size
      t.boolean :active
      t.timestamps
    end
  end
end
