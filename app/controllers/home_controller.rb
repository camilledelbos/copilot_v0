class HomeController < ApplicationController
  def index
     @titre = "Accueil"
     @maps = Map.all
  end

  def help
     @titre = "Help"
  end

  def contact
     @titre = "Contact"
  end
end
