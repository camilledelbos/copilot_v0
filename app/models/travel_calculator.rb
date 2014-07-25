
def better_path(from_stage, available_stages)
	return [] if available_stages.empty?
	better = available_stages.sort_by{|s| s.distance_from(from_stage)}.first
	reste = available_stages - [better]
  [better].concat(better_path(better, reste))
end

def sunway(from_stage, available_stages)

	#Ancienne proposition de Yaf
	# CSV.foreach(File.join(Rails.root, 'db/climate_db/climate_01.csv')) do |row|
	# 	puts row.inspect
	# end

	#attention ne recherche que dans 1 fichier, manque les 11 autres
	csv = CSV.parse(File.read('db/climate/climate_01.csv'), { headers:true })
	csv.each {|row| puts row.inspect }
	
	#obtenir les notations des available_stages 
	# => renvoi NoMethodError: undefined method `[]' for nil:NilClass
	# => du au format de donnée ?
	notations = []
	available_stages.each do |stage|
	  notations << csv.find {|row| row['city'] == stage }['notation']
	end

	puts notations

	#ordonner les notations par ordre décroissant
	#=> limite : ne propose qu'un ordre alors que plusieurs sont possibles
	notation.sort.reverse
		

	[[montreuil, turin, bali, sydney, berlin], [montreuil, turin, sydney, bali, berlin]]
end