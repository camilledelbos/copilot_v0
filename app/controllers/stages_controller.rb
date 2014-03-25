class StagesController < ApplicationController

	def new
		@travel = Travel.find(params[:travel_id])
	    @stage = @travel.stages.build

		respond_to do |format|       
	        format.js
	    end
	end

	def create
		
		@travel = Travel.find(params[:travel_id])
		@stage = @travel.stages.new(stage_params)
		

		respond_to do |format|
		    if  @stage.save
		        format.html { redirect_to travel_path(@travel), notice: 'Stage was successfully created.' }
		        # format.js
		    else
	       		format.html { render action: 'new' }
	      	end
	    end
	end
	
def destroy
    @stage = Stage.find(params[:id])
    if @stage.present?
      @stage.destroy
    end
    respond_to do |format|
	      format.html { redirect_to travel_route_stage_path }
	      format.js
	end
end

def sort
    # route = Route.find(params[:route_id])
	sort_params[:id].each_with_index do |stage_id, position|
		id = id.split('_')[1]
        stage = stages.find(id)
  	    stage.stage_position = position
  	    stage.save
  	end
	render nothing: true
end



 private
    def sort_params
      params.permit(:stages_id => [])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stage_params
    	params.require(:stage).permit(:address, :departure_date, :duration, :route_id, :stage_position)
    end

end

