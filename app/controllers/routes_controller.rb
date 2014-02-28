class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  # GET /routes
  # GET /routes.json
  def index
    @titre = "Route"
    @routes = Route.all

    end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @titre = "My Routes"
    @route = Route.find(params[:id])

  # A VERIFIER AVEC ANDREI
    @stage = Stage.find(params[:id])
    @stages = @route.stages.all



    @user_route = current_user

  # A MODIFIER AVEC ANDREI (n retrouve pas l'id du Travel car recherche l'id du Travel avec l'id de la Route or plusieurs Route dans 1 Travle)
    @travel = Travel.find(params[:id])

     # fill bounds: http://leafletjs.com/reference.html#latlngbounds
    @bounds = @route.stages.map{ |l| [l.latitude, l.longitude] }


end
  # GET /routes/new
  def new
    @route = Route.new
    1.times { @route.stages.build }

  end

  # GET /routes/1/edit
  def edit
  end

  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(route_params)
    travel = @route.travel

    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render action: 'show', status: :created, location: @route }
      else
        format.html { render action: 'new' }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_params
      params.require(:route).permit(:route_name, stages_attributes: [:address, :departure_date, :duration])
    end
end
