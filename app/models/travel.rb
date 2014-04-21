class Travel < ActiveRecord::Base

	belongs_to :user
	has_many :stages, -> { order(:stage_position) }

    # def add_stage(stage_params)
    #     puts "-" * 30
    #     puts stage_params
    #     stage_params = {stage_position: stages.count + 1}.merge(stage_params)
    #     puts stage_params
    #     puts "-" * 30
    #     stages.create(stage_params)
    # end

    def duration    
        stages.sum(:duration)
    end

    def distance
        distance = 0
        bounds = stages.map{|s| [s.latitude, s.longitude]}
        for i in 0..(bounds.count - 1)
            unless i == (bounds.count - 1)
                distance += Geocoder::Calculations.distance_between(bounds[i], bounds[i+1])
            end
        end
        distance.round
    end

    def travel_budget
        budget = 0
        country_budget = 0
        self.stages.each do |stage|
            country_code = Geocoder.search(stage.address).first.country_code
            country_budget = Country.find_by(country_code: country_code).daily_budget * stage.duration   
        budget += country_budget
    end
        budget
    end

    # def country
    #     travel = Travel.find(params[:id])
    #     # city = travel.stages(stage_params).address
    #     # city = stages(stage_params[:address])
    #     @country = Geocoder.search(travel.stages(params[:address]).first.country

    #     @country
    # end

    # def info_ville
    #     GeoNamesAPI::Wikipedia.all(c.latitude, c.longitude)
    # end

    # def reverse_geocoded_by :latitude, :longitude do |obj,results|
    #         if geo = results.first
    #             obj.country = geo.country_code
    #         end
    #     end
    # after_validation :reverse_geocode
    # end


end
	