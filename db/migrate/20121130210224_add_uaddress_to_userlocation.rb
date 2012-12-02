class AddUaddressToUserlocation < ActiveRecord::Migration
  def change
  	add_column :userlocations, :uAddress, :string
  end
end
