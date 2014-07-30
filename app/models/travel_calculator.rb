
def better_path(from_stage, available_stages)
	return [] if available_stages.empty?
	better = available_stages.sort_by{|s| s.distance_from(from_stage)}.first
	reste = available_stages - [better]
  [better].concat(better_path(better, reste))
end

def sunway(from_stage, available_stages)
  stages_by_notation = {}
  (available_stages - [from_stage]).each do |s|
  	climate_notation = Climate.for_city_and_month(s.address, s.end_date.month).first.notation
  	stages_by_notation[climate_notation] = s
  end

  sorted_stages = [from_stage]
  stages_by_notation.keys.sort.reverse.each do |note|
    sorted_stages << stages_by_notation[note]
  end
  sorted_stages
end