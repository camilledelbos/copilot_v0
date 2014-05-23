class LandingController < ApplicationController
skip_before_filter :authenticate_user!
layout "less-is-more"

  def landing
    @prospect = Prospect.new
  end

  def landing2
    @prospect = Prospect.new
  end
end
