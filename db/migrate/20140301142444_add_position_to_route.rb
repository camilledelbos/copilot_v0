class AddPositionToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :route_position, :integer
  end
end
