class AddDepartureDateToMap < ActiveRecord::Migration
  def change
    add_column :maps, :departure_date, :string
  end
end
