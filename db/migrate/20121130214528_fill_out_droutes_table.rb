class FillOutDroutesTable < ActiveRecord::Migration
  def up
  	add_column :droutes, :drive_time_int, :integer
  	add_column :droutes, :drive_time_str, :string
  	add_column :droutes, :distance_int, :integer
  	add_column :droutes, :distance_str, :string
  end

  def down
  end
end
