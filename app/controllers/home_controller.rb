class HomeController < ApplicationController
  def index
     @titre = "Home"
  end

 def profile
     @titre = "Profile"
  end

  def help
     @titre = "Help"
  end

  def contact
     @titre = "Contact"
  end
end
