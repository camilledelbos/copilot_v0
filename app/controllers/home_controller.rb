class HomeController < ApplicationController
 add_breadcrumb "home", :root_path, :options => { :title => "Home" }

  def index
     @titre = "Home"
     @travel = Travel.all
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
