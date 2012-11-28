class AddSnowcountryIdToResorts < ActiveRecord::Migration
  def change
  	add_column :resorts, :snowcountry_id, :integer
  	add_index :resorts, :snowcountry_id
  end
end
