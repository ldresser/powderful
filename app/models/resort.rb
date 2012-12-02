class Resort < ActiveRecord::Base
	extend Geocoder::Model::ActiveRecord
  attr_accessible :address, :area, :city, :elevation_base, :elevation_peak, :lifts, :longest_trail, :name, :pr_advanced, :pr_beginner, :pr_expert, :pr_intermediate, :runs, :state, :trail_map, :url, :vertical_drop, :zip, :latitude, :longitude, :snowcountryid


	geocoded_by :gAddress
	# "#{:address}, #{:city}, #{:state} #{:zip}"
	after_validation :geocode

	geocoded_by :gAddress

def gAddress
  [address, city, state, zip].compact.join(', ')
end


end
