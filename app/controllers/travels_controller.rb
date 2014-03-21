class TravelsController < ApplicationController
  before_action :set_travel, only: [:show, :edit, :update, :destroy]

 
  def index
    @travels = current_user.travels

  end

 
  def show
    @travel
    @user_travel = current_user
  end



  def new
    @travel = Travel.create(name: "TravelName")
    @travel.routes.create(route_name: "RouteName")
    @stage =  @travel.routes.first.stages.build

  end

  def edit
  end

  
  def create

    # @travel.user = current_user
    respond_to do |format|
      if @stage.save
        format.html { redirect_to travel_path, notice: 'Travel was successfully created.' }
      else
        format.html { render action: 'new' }
        format.json { render json: @stage.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @travel.update(travel_params)
        format.html { redirect_to @travel, notice: 'Travel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @travel.destroy
    respond_to do |format|
      format.html { redirect_to travels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travel
      @travel = Travel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def travel_params
      params.require(:travel).permit(:name)
    end

    def route_params
       params.require(:route).permit(:route_name)

    end

    def stage_params
       params.require(:stage).permit(:stage, :duration, :departure_date)
    end
end
