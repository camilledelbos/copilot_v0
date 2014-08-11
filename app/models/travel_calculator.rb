

#!!! Tout ce qui a là ne sert plus pour le moment.


def better_path(from_stage,available_stages)
  return [] if available_stages.empty?
  better = available_stages.sort_by{|s| s.distance_from(from_stage)}.first
  reste = available_stages - [better]
  path = [better] << reste.each.sort_by{|s| s.distance_from(better)}
end


# def better_way(from_stage,available_stages)
#       better = {}
#      return {} if available_stages.empty?
        
#       else
#         reste = available_stages - [from_stage]
#         reste.each_with_index do |s, i|
#           if s.geocoded?
#             better[s.address] = s.distance_from(from_stage).round 
#           end
#         end
#       end
#       better.sort_by{|s, i| i }
#     end





# def sunway(from_stage, available_stages)
#   stages_by_notation = {}
#   (available_stages - [from_stage]).each do |s|
#   	climate_notation = Climate.for_city_and_month(s.address, s.end_date.month).first.notation
#     s.notation = climate_notation
#   	stages_by_notation[s.id] = s
#   end
  
#   stages_by_notation = Hash[stages_by_notation.sort_by {|key, stage| stage}]

#   sorted_stages = [from_stage]
#   stages_by_notation.keys.sort.reverse.each do |note|
#     sorted_stages << stages_by_notation[note]
#   end
#   sorted_stages
# end

def sunway(from_stage, available_stages)
  stages_with_notation = []
  (available_stages - [from_stage]).each do |s|
    s.notation = Climate.for_city_and_month(s.address, s.end_date.month).first.notation
    stages_with_notation.push s
  end
  stages = stages_with_notation.sort_by {|stage| stage.notation}.reverse
  stages.unshift from_stage
end 

def climateway(available_stages)
  stages_with_notation = []
  available_stages.each do |s|
  s.notation = Climate.for_city_and_month(s.address, s.end_date.month).first.notation
  stages_with_notation.push s
  end
  stages = stages_with_notation
  stages.unshift from_stage
end
