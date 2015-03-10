class ChangeDecimalColumnsToFloatsOnTicket < ActiveRecord::Migration
  def change
    change_column :tickets, :discount, :float
    change_column :tickets, :min_total_spend, :float
    change_column :tickets, :ticket_price, :float
    change_column :tickets, :loss_per_ticket, :float
  end
end
