class LandingController < ApplicationController
layout "less-is-more"

  def landing
    @prospect = Prospect.new
  end

  def landing2
    @prospect = Prospect.new
  end
end