class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.integer :type
      t.references :user, foreign_key: true
      t.text :address
      t.string :city
      t.string :country
      t.decimal :daily_price, :precision => 8, :scale => 2

      t.timestamps
    end
    add_index :places, :type
  end
end
