class RemoveStopOffToStages < ActiveRecord::Migration
  def change

  	 remove_column :stages, :stopoff, :string
  	 remove_column :routes, :departure_date, :date
  end
end
