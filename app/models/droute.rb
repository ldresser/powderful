class Droute < ActiveRecord::Base
  attr_accessible :id, :latitude, :longitude, :origin, :resort_id
end
