class CreateContinents < ActiveRecord::Migration
  def change
    create_table :continents do |t|
      t.string :continent_code
      t.string :continent_name

      t.timestamps
    end
  end
end
