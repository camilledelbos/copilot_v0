class HomeController < ApplicationController
  def index
     @titre = "Accueil"
  end

  def help
     @titre = "Help"
  end

  def contact
     @titre = "Contact"
  end
end
