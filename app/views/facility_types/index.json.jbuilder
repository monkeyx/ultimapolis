json.array!(@facility_types) do |facility_type|
  json.extract! facility_type, :id, :name, :district_id, :description, :icon, :build_cost, :maintenance_cost, :employees, :automation, :power_consumption, :power_generation, :pollution
  json.url facility_type_url(facility_type, format: :json)
end
