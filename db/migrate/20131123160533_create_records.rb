class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :type
      t.integer :asset_id
      t.datetime :date
      t.decimal :percentage_delta, precision: 10, scale: 5
      t.decimal :value_delta, precision: 10, scale: 5
      t.decimal :value, precision: 10, scale: 5

      t.timestamps
    end
  end
end
