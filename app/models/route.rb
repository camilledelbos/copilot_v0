class Route < ActiveRecord::Base

	has_many :stage
	belongs_to :travel

end
