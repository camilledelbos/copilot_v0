class LandingController < ApplicationController

  def landing
    @prospect = Prospect.new
  end
end