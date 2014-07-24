
def better_path(from_stage, available_stages)
	return [] if available_stages.empty?
	better = available_stages.sort_by{|s| s.distance_from(from_stage)}.first
	reste = available_stages - [better]
  [better].concat(better_path(better, reste))
end
