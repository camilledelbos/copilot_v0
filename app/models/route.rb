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

    def add_stage(stage_params)
        puts "-" * 30
        puts stage_params
        stage_params = {stage_position: stages.count + 1}.merge(stage_params)
        puts stage_params
        puts "-" * 30
        stages.create(stage_params)
    end
end
