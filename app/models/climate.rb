require 'csv'

class Climate < ActiveRecord::Base

  scope :for_city, -> (city) { where(main_city: city)}
  scope :for_city_and_month, -> (city, month) { for_city(city).where(month: month) }

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

end