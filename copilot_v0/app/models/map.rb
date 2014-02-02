class Map < ActiveRecord::Base

	belongs_to :user

	# attr_accessor :country_code

  geocoded_by :address
  after_validation :geocode
	
  def address
  [city, country].compact.join(', ')
end

  # Assuming country_select is used with User attribute `country_code`
  # This will attempt to translate the country name and use the default
  # (usually English) name if no translation is available

	# def country_name
 #    country = Country[country_code]
 #    country.translations[I18n.locale.to_s] || country.name
 #  end



end
