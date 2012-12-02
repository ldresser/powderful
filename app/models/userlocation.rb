class Userlocation < ActiveRecord::Base
  attr_accessible :address, :lat, :lng

#  	reverse_geocoded_by :latitude => :lat, :longitude => :lng, :address => :uAddress
#	after_validation :reverse_geocode  # auto-fetch address

end
