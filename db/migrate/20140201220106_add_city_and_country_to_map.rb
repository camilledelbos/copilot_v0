class AddCityAndCountryToMap < ActiveRecord::Migration
  def change
    add_column :maps, :city, :string
    add_column :maps, :country, :string
  end
end
