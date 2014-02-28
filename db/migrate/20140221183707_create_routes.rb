class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :route_name
      t.date :departure_date

      t.timestamps
    end
  end
end
