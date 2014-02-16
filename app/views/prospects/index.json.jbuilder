json.array!(@prospects) do |prospect|
  json.extract! prospect, :id, :email
  json.url prospect_url(prospect, format: :json)
end
