json.array!(@facilities) do |facility|
  json.extract! facility, :id, :citizen_id, :facility_type_id, :powered, :maintained, :utilised, :level
  json.url facility_url(facility, format: :json)
end
