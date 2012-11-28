class CreateResorts < ActiveRecord::Migration
  def change
    create_table :resorts do |t|
      t.string :name
      t.integer :runs
      t.float :pr_beginner
      t.float :pr_intermediate
      t.float :pr_advanced
      t.float :pr_expert
      t.integer :area
      t.integer :elevation_base
      t.integer :elevation_peak
      t.integer :vertical_drop
      t.integer :longest_trail
      t.integer :lifts
      t.string :url
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :trail_map

      t.timestamps
    end
  end
end
