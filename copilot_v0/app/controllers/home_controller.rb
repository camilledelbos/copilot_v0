class HomeController < ApplicationController
  def index
     @titre = "Accueil"
  end

  def help
     @titre = "Help"
  end

  def landing
    @prospect = Prospect.new
  end

  def contact
     @titre = "Contact"
  end
end
