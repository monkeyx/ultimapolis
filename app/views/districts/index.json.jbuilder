json.array!(@districts) do |district|
  json.extract! district, :id, :name, :skill_id, :transport_capacity, :civilians, :automatons, :unrest, :health, :policing, :social, :environment, :housing, :education, :community, :creativity, :aesthetics, :crime, :corruption
  json.url district_url(district, format: :json)
end
