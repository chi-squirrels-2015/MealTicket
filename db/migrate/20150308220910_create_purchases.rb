class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :ticket
      t.string     :purchaser_name
      t.string     :phone_number
      t.string     :email
      t.string     :confirmation_id
      t.boolean    :paid

      t.timestamps null: false
    end
  end
end
