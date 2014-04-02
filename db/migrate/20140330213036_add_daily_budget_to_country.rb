class AddDailyBudgetToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :daily_budget, :integer
  end
end
