class TravelsController < ApplicationController
  before_action :set_travel, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Travels", :travels_path

  # GET /travels
  # GET /travels.json
  def index
    @titre = "Travel"
    @travels = current_user.travels

  end

  # GET /travels/1
  # GET /travels/1.json
  def show
    add_breadcrumb Travel.find(params[:id]).name, travels_path
    
    @titre = "Travel"
    @user_travel = current_user
  end

  # GET /travels/new
  def new
    @travel = Travel.new
  end

  # GET /travels/1/edit
  def edit
  end

  # POST /travels
  # POST /travels.json
  def create
    @travel = Travel.new(travel_params)
    @travel.user = current_user
    respond_to do |format|
      if @travel.save
        format.html { redirect_to @travel, notice: 'Travel was successfully created.' }
      else
        format.html { render action: 'new' }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travels/1
  # PATCH/PUT /travels/1.json
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

  # DELETE /travels/1
  # DELETE /travels/1.json
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
end
