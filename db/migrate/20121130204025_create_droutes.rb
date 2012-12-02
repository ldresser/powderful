class CreateDroutes < ActiveRecord::Migration
  def change
    create_table :droutes do |t|
      t.integer :id
      t.string :origin
      t.integer :resort_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
