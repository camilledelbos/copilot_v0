class Travel < ActiveRecord::Base

	belongs_to :user
	has_many :stages, -> { order(:stage_position) }
	

    def add_stage(stage_params)
        puts "-" * 30
        puts stage_params
        stage_params = {stage_position: stages.count + 1}.merge(stage_params)
        puts stage_params
        puts "-" * 30
        stages.create(stage_params)
    end


end
	