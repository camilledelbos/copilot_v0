class StagesController < ApplicationController
  def edit

  	respond_to do |format|
      if @stage.update(stage_params)
        format.html { redirect_to route_path, notice: 'Stage was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

def new
@stage = Stage.new
end

private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def stage_params
      params.require(:stages).permit(:address, :departure_date, :duration)
    end



end
