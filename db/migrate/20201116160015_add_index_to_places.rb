class AddIndexToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_index :places, :city
    add_index :places, :country
  end
end
