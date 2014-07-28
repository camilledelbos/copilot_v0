class Climate < ActiveRecord::Base
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      climate_hash = row.to_hash # exclude the price field
      climate = Climate.where(id: climate_hash["id"])

      if climate.count == 1
        # climate.first.update_attributes(climate_hash.except("price"))
      else
        Climate.create!(climate_hash)
      end
    end
  end

  def notation
  

  end

end