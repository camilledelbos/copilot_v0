class ClimatesController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    @climate = Climate.all
  end

  def import
    begin
      Climate.import(params[:file])
      redirect_to root_url, notice: "Climates imported."
    rescue
      redirect_to root_url, notice: "Invalid CSV file format."
    end
  end
end
