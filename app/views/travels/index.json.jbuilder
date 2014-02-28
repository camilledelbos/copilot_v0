json.array!(@travels) do |travel|
  json.extract! travel, :id, :name
  json.url travel_url(travel, format: :json)
end
