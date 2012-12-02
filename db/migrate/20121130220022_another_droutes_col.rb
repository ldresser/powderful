class AnotherDroutesCol < ActiveRecord::Migration
  def up
  	add_column :droutes, :resort_address, :string
  end

  def down
  end
end
