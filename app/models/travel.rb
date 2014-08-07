require 'travel_calculator'

class Travel < ActiveRecord::Base

	belongs_to :user
	has_many :stages, -> { order(:stage_position) }

    def departure_date
        initial_stage.departure_date
    end

	def add_stage(stage)
		self.stages << stage
	end

    def initial_stage
		self.stages.first
	end

	def chemin_optimal
        better = {}
        if self.stages.empty?
            return {}
        else
            available_stages = self.stages - [initial_stage]
            available_stages.each_with_index do |s, i|
                if s.geocoded?
                better[s.address] = s.distance_from(initial_stage).round 
                end
            end
        end
        better.sort_by{|s, i| i }
        # better_path(initial_stage, self.stages)
		
	end

    # def betterway
    #     if self.stages.empty?
    #     return better = []
    #     else
    #         available = self.stages - initial_stage
    #         available.sort_by do |s|
    #             s.distance_from(initial_stage)
    #             better.push s.address
    #         end
    #     puts better
    #     end
    # end
            
    
    def stage_duration
        if self.stages.where(stage_position: 0).first
            duration = 0
        else
            self.stages.each {|s| s.departure_date - self.stages.find(stage_position: s.stage_position-1).departure_date}
        end
    end

####
    def meteo
        stages_with_notation = []
        self.stages.each do |s|
            if stages_with_notation.empty?
                s.notation = Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.notation
                stages_with_notation.push s.notation
            elsif s.id.nil?
                next
            else
                s.notation = Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.notation 
                stages_with_notation.push s.notation 
            end
       end
       p stages_with_notation
    end

    





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

    def azaz
        stages.order("stage_position").map{ |l| [l.latitude, l.longitude] }
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

    # def add_stage(stage_params)
    #     puts "-" * 30
    #     puts stage_params
    #     stage_params = {stage_position: stages.count + 1}.merge(stage_params)
    #     puts stage_params
    #     puts "-" * 30
    #     stages.create(stage_params)
    # end


end
