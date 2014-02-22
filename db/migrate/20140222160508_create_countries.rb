class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :country_code
      t.string :capital
      t.integer :pop_density
      t.string :geo_zone
      t.integer :surface_area
      t.integer :pop_count

      t.timestamps
    end
  end
end
