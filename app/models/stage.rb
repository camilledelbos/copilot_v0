class Stage < ActiveRecord::Base

belongs_to :travel

geocoded_by :address
after_validation :geocode
	
	# def address
 #  		[city, country].compact.join(', ')
	# end

	def distance
		
		
	end



end
