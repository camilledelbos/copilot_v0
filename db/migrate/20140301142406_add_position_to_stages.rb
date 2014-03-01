class AddPositionToStages < ActiveRecord::Migration
  def change
    add_column :stages, :stage_position, :integer
  end
end
