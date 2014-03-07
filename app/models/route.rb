class Route < ActiveRecord::Base

	has_many :stages
	belongs_to :travel

	accepts_nested_attributes_for :stages

    def departure_date
    	first_stages = stages.where(stage_position: 1).limit(1)
    	date  = nil
    	if first_stages.any?
    		date = first_stages.first.departure_date
    	end
    	date
    end
end
