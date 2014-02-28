class AddRouteIdToStages < ActiveRecord::Migration
  def change
		add_column :stages, :route_id, :string
  		add_index :stages, :route_id
  end
end
