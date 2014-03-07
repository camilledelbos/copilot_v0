class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]
  
  add_breadcrumb "Travels", :travels_path
  add_breadcrumb "Routes", :travel_routes_path


  def index
    @titre = "Route"
    @routes = Route.where travel_id: params[:travel_id]
  end

  def show
    add_breadcrumb Route.find(params[:id]).route_name, travel_routes_path
    @titre = "My Routes"

    @stages = @route.stages.order("stage_position")

    @user_route = current_user

  # A MODIFIER AVEC ANDREI (n retrouve pas l'id du Travel car recherche l'id du Travel avec l'id de la Route or plusieurs Route dans 1 Travle)
    @travel = @route.travel

     # fill bounds: http://leafletjs.com/reference.html#latlngbounds
    @bounds = @route.stages.map{ |l| [l.latitude, l.longitude] }
  end


  def new
    add_breadcrumb "New Route", new_travel_route_path
    @route = Route.new
    @route.stages.build
    @travel = Travel.find(params[:travel_id])
  end


  def edit
  end


  def create
    @route = Route.new(route_params[:route].merge(travel_id: route_params[:travel_id]))
      
      if @route.save
        redirect_to travel_routes_path, notice: 'Route was successfully created.'
      else
        render action: 'new'
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


def sort
  params[:stages_attributes].each_with_index do |id, index|
  Stage.update_all({stage_position: index+1}, {id: id})
  end
render nothing: true
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_params
      # params.permit(:travel_id, :route => [:route_name])
      params.permit(:travel_id, :route => [:route_name, :stages_attributes => [:address, :departure_date, :duration]])
      # params.require(:route).permit(:route_name, :travel_id, stages_attributes: [:address, :departure_date, :duration])
    end
end
