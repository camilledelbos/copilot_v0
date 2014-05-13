class AddCopilotRateToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :copilot_rate, :integer
  end
end
