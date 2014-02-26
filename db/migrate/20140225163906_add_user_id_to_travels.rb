class AddUserIdToTravels < ActiveRecord::Migration
  def change
  	  	  	add_column :travels, :user_id, :integer

  end
end
