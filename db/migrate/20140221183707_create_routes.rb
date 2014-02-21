class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :route_name
      t.datetime :departure_date

      t.timestamps
    end
  end
end
