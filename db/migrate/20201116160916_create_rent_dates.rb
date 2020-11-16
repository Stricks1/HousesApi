class CreateRentDates < ActiveRecord::Migration[5.2]
  def change
    create_table :rent_dates do |t|
      t.references :place, foreign_key: true
      t.references :user, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.decimal :rent_price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
