class Route < ActiveRecord::Base

	has_many :stages
	belongs_to :travel

end
