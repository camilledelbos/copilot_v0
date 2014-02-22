class Stage < ActiveRecord::Base

belongs_to :Travel


geocoded_by :address
  after_validation :geocode
	
	def address
  		[city, country].compact.join(', ')
	end
end
