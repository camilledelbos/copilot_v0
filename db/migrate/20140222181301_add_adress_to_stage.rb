class AddAdressToStage < ActiveRecord::Migration
  def change
    add_column :stages, :address, :string
  end
end
