class Stage < ActiveRecord::Base

belongs_to :route


geocoded_by :address
  after_validation :geocode
	
	# def address
 #  		[city, country].compact.join(', ')
	# end
end
