class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :places, :type, :location_type
  end
end
