class StagesController < ApplicationController

	def new

		@travel = Travel.find(params[:travel_id])
		@route = Route.find(params[:route_id])

		respond_to do |format|       
	        format.js
	    end
	end

	def create
		@travel = Travel.find(params[:travel_id])
		@route = Route.find(params[:route_id])
		@stage = Stage.new(stage_params[:stage])
		@route.stages << @stage

		respond_to do |format|
		    if @stage.save
		        format.html { redirect_to travel_route_stage_path, notice: 'Todo was successfully created.' }
		        format.js
		    else
	       		format.html { render action: 'new' }
	      	end
	    end
	end
	
	# def destroy
	#     @stage.destroy
	#     respond_to do |format|
	#       format.html { redirect_to travel_route_stage_path }
	#       format.js
	#     end
 #  	end

 private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def stage_params
      params.permit(:stage => [:address, :departure_date, :duration])
    end

end

