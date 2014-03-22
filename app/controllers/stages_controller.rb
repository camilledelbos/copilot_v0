class StagesController < ApplicationController

	def index
		 @stages = Stage.all
	end
	
	def show
		@stage = Stage.all
	end

	def new

	    @stage = Stage.new(:route_id=>18)

		respond_to do |format|       
	        format.js
	    end
	end

	def create
		
		@stage = Stage.new(stage_params)


		

		respond_to do |format|
		    if  @stage.save
		        format.html { redirect_to @stage.route, notice: 'Stage was successfully created.' }
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
    route = Route.find(params[:route_id])
	sort_params[:stages_id].each_with_index do |stage_id, position|
		id = stage_id.split('_')[1]
        stage = route.stages.find(id)
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
    	params.require(:stage).permit(:address, :departure_date, :duration, :route_id)
    end

end

