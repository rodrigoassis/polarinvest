class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :investment_id
      t.datetime :date
      t.string :transaction_type
      t.decimal :total_value, precision: 10, scale: 5
      t.string :investment_type
      t.integer :shares_quantity
      t.decimal :unit_value, precision: 10, scale: 5

      t.timestamps
    end
  end
end
