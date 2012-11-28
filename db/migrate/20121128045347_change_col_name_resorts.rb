class ChangeColNameResorts < ActiveRecord::Migration
  
  def change
  	remove_column :resorts, :snowcountry_id
  	# remove_index :resorts, :snowcountry_id
  	add_column :resorts, :snowcountryid, :integer
  end
end
