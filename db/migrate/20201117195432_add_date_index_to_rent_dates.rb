class AddDateIndexToRentDates < ActiveRecord::Migration[5.2]
  def change
    add_index :rent_dates, :start_date
    add_index :rent_dates, :end_date
  end
end
