class CreateMainCities < ActiveRecord::Migration
  def change
    create_table :main_cities do |t|
      t.string :city

      t.timestamps
    end
  end
end
