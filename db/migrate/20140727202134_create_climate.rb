class CreateClimate < ActiveRecord::Migration
  def change
    create_table :climates do |t|
      t.string  :couple
      t.string  :country
      t.string  :main_city
      t.integer  :month
      t.integer :sunshine_duration
      t.float :t_average_min
      t.float :t_average_max
      t.float :t_average
      t.float :t_best_min
      t.float :t_best_max
      t.float :precipitation
      t.integer :rainy_days
      t.integer :notation
    end
  end
end
