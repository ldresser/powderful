class AddTravelDataToResorts < ActiveRecord::Migration
  def change
  	  	add_column :resorts, :drive_time_int, :integer
  		add_column :resorts, :drive_time_str, :string
  		add_column :resorts, :distance_int, :integer
  		add_column :resorts, :distance_str, :string
  end
end
