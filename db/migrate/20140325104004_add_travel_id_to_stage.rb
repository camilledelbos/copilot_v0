class AddTravelIdToStage < ActiveRecord::Migration
  def change
    add_reference :stages, :travel, index: true
  end
end
