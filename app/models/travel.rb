require 'travel_calculator'

class Travel < ActiveRecord::Base

    belongs_to :user
    has_many :stages, -> { order(:stage_position) }

    def departure_travel
        self.initial_stage.departure_date
    end

    def add_stage(stage)
        self.stages << stage
    end

    def initial_stage
        self.stages.where(stage_position: 0).first
    end
    
    def stage_duration
        if self.initial_stage         #si Stage à stage_position 0 alors durée 0 et date de départ du Travel
             duration = 0
             departure_travel
        elsif self.stages.each {|s| s.duration.nil?}
            duration = self.stages.each {|s| s.departure_date - self.stages.find(stage_position: s.stage_position-1).departure_date}
        elsif self.stages.each {|s| s.departure_date.nil?}
            departure_date = self.stages.each {|s| self.stages.find(stage_position: s.stage_position-1).duration + self.stages.find(stage_position: s.stage_position-1).departure_date}
        end
    end

    def stages_quantity
        self.stages.count
    end
    
    def duration
        stages.sum(:duration)
    end

    def stage_date
        self.stages.each {|s| s.departure_date}
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
        better.sort_by{|s,i| i }
        # better_path(initial_stage, self.stages)
    end

    def meteo_path
        stages_with_notation = []
        self.stages.each do |s|
            if stages_with_notation.empty?
                s.notation = Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.notation
                # (self.departure_date ++ s.duration).month)
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
    def climat
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

#       def climat
# +        stages_concerned = []
# +        self.stages.each do |s|
# +            if stages_concerned.empty?
# +                s = Climate.for_city_and_month(s.address.capitalize, s.departure_date.month)
# +                stages_concerned.push s
# +            elsif s.id.nil?
# +                next
# +            else
# +                s = Climate.for_city_and_month(s.address.capitalize, s.departure_date.month)
# +                stages_concerned.push s
# +                stages_concerned.flatten!
# +            end
# +       end
# +       p stages_concerned
# +    end

    # def self.global_notation
    #     if stages_with_notation.empty?
    #     return []

    # #A VERIFIER #à une date donnée, valeur attribuée à une t°
    #     def temperature_notation
    #         temperature_notations = []
    #         temperature_notation = 0
    #         self.stages.each do |s|
    #             if Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.t_average > 40
    #                 temperature_notation = 1
    #             elsif Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.t_average >= 35
    #                 temperature_notation = 2
    #             elsif Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.t_average >= 28
    #                 temperature_notation = 3
    #             elsif Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.t_average >= 23
    #                 temperature_notation = 4
    #             elsif Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.t_average >= 21
    #                 temperature_notation = 5
    #             elsif Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.t_average >= 17
    #                 temperature_notation = 4
    #             elsif Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.t_average >= 13
    #                 temperature_notation = 3
    #             elsif Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.t_average >= 8
    #                 temperature_notation = 2
    #             else Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.t_average < 8
    #                 temperature_notation = 1
    #             end
    #         temperature_notations.sum << temperature_notation
    #         end
    #         temperature_notations
    #     end      

    # #A VERIFIER #à une date donnée, valeur attribuée à une hauteur de précipitation
    #     def precipitation_note
    #         precipitation_notations = []
    #         precipitation_notation = 0
    #         self.stages.each do |s|
    #             if Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.precipitation.empty?
    #                 next
    #             else
    #                 if Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.precipitation < 50
    #                     precipitation_notation = 5
    #                 elsif Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.precipitation < 100
    #                     precipitation_notation = 4
    #                 elsif Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.precipitation < 150
    #                     precipitation_notation = 3
    #                 elsif Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.precipitation < 200
    #                     precipitation_notation = 2
    #                 else Climate.for_city_and_month(s.address.capitalize, s.departure_date.month).first.precipitation < 250
    #                     precipitation_notation = 1
    #                 end
    #             end
    #         precipitation_notations.sum << precipitation_notation
    #         end
    #         precipitation_notations
    #     end
    #     stages_with_notation = temperature_notation + precipitation
    # end



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
