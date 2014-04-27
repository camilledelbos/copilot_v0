class AddNbTravellerToTravel < ActiveRecord::Migration
  def change
    add_column :travels, :nb_traveller, :integer
  end
end
