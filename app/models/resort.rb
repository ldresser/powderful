class Resort < ActiveRecord::Base
  attr_accessible :address, :area, :city, :elevation_base, :elevation_peak, :lifts, :longest_trail, :name, :pr_advanced, :pr_beginner, :pr_expert, :pr_intermediate, :runs, :state, :trail_map, :url, :vertical_drop, :zip, :latitude, :longitude, :snowcountryid

	# def self.prep_for_view()
	# 	# Join the resorts table onto the @scHash hash
	# 	# where scHash ID = resorts snow snowcountry_id
	# 	@resorts = Resort.all
	# 	@resorts.each do |resort|
	# 	  resort["sc_resortName"] = @scHash["resort.snowcountry_id"]["resortName"]
	#   	end
	 	
	#  end 
end
