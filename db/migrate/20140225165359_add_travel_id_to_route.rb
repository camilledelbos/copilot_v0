class AddTravelIdToRoute < ActiveRecord::Migration
  def change
  	add_column :routes, :travel_id, :integer

  end
end
