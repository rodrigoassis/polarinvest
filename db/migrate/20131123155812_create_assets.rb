class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name
      t.string :type
      t.string :ticker

      t.timestamps
    end
  end
end
