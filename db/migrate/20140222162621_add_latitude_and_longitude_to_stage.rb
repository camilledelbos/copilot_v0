class AddLatitudeAndLongitudeToStage < ActiveRecord::Migration
  def change
    add_column :stages, :latitude, :float
    add_column :stages, :longitude, :float
  end
end
