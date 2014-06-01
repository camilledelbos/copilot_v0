
def better_path(from_stage, available_stages)
	puts "yaf" * 10
	puts "available_stages #{available_stages.to_a}"
	puts "yaf" * 10
	return [] if available_stages.empty?
	better = available_stages.sort_by{|s| s.distance_from(from_stage)}.first
	reste = available_stages - [better]
  [better].concat(better_path(better, reste))
end
