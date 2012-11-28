class AddLatLngToResorts < ActiveRecord::Migration
  def change
  	add_column :resorts, :latitude, :float
  	add_column :resorts, :longitude, :float
  end
end
