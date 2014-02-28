class AddDepartureDateToStages < ActiveRecord::Migration
  def change
  	add_column :stages, :departure_date, :date
  end
end
