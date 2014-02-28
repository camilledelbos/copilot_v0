json.array!(@routes) do |route|
  json.extract! route, :id, :route_name, :departure_date
  json.url route_url(route, format: :json)
end
