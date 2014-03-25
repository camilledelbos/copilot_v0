class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]
  


  def index
    @titre = "Route"
    @routes = Route.where travel_id: params[:travel_id]
  end

  def show

    @titre = "My Routes"
    @route = Route.find(params[:id])

    @stages = @route.stages.order("stage_position")
    @user_route = current_user

  # A MODIFIER 
    @travel = @route.travel

   
  end


  def new
    @route = Route.new
    @route.stages.build
    @travel = Travel.find(params[:travel_id])

  end


  def edit
  end


  def create
    @route = Route.new(route_params[:route].merge(travel_id: route_params[:travel_id]))

      respond_to do |format|
      if @route.save
        format.html { redirect_to travel_routes_path, notice: 'Route was successfully created.' }
        format.js
      else
        format.html { render action: 'new' }
      end

    end
  end


  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to travel_route_path(@travel), notice: 'Route was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_params
      # params.permit(:travel_id, :route => [:route_name])
      params.permit(:travel_id, :route => [:route_name, :stages_attributes => [:address, :departure_date, :duration, :stage_position]])
      # params.require(:route).permit(:route_name, :travel_id, stages_attributes: [:address, :departure_date, :duration])
    end
end
