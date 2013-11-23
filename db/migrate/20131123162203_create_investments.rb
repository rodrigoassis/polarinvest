class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.integer :user_id
      t.integer :asset_id

      t.timestamps
    end
  end
end
