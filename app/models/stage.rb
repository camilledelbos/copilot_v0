class Stage < ActiveRecord::Base
    attr_accessor :notation

    belongs_to :travel
    has_one :country, foreign_key: :country_code

    validates_presence_of :travel

    geocoded_by :address
    after_validation :geocode

# reverse_geocoded_by :latitude, :longitude
# after_validation :reverse_geocode  # auto-fetch address

	# def address
 #  		[city, country].compact.join(', ')
	# end

    def first_stage
        self.stage_position == 0
    end

    def end_date
        (travel.departure_date + self.duration ).to_s
    end

    def month_date
        (travel.departure_date + self.duration).month
    end

    def reverse_geocode_both
        start_coordinates = [self.from_lat, self.from_long]
        end_coordinates = [self.to_lat, self.to_long]
        self.from_string = Geocoder.address(start_coordinates)
        self.to_string = Geocoder.address(end_coordinates)
    end


    # def reverse_geocoded_by :latitude, :longitude do |obj,results|
    #         if geo = results.first
    #             obj.country = geo.country_code
    #         end
    #     end
    # after_validation :reverse_geocode
    # end

    def daily_budget
        country_code = Geocoder.search(self.address).first.country_code
        Country.find_by(country_code: country_code).daily_budget
    end

    def budget_by_address
        daily_budget * self.duration
    end
# code = Geocoder.search(pays).first.country_code
# info = Country.new(:country_code => "AU", :daily_budget => 60)
# money = Country.find_by(country_code: code).daily_budget

    def distance_from(other_stage)
      return 1 if other_stage == self || other_stage.nil?
      Geocoder::Calculations.distance_between(self.position, other_stage.position)
    end

    def position
      [self.latitude, self.longitude]
    end

end
