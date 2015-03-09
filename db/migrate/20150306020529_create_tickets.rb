class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.belongs_to :promotion
      t.decimal :discount
      t.decimal :min_total_spend
      t.integer :group_size
      t.boolean :active
      t.decimal :ticket_price
      t.decimal :loss_per_ticket
      t.timestamps
    end
  end
end
