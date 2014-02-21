class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :stopoff
      t.integer :duration

      t.timestamps
    end
  end
end
