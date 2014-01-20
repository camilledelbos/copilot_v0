json.array!(@maps) do |map|
  json.extract! map, :id, :map_name
  json.url map_url(map, format: :json)
end
