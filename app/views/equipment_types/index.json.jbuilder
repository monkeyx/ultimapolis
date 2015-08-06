json.array!(@equipment_types) do |equipment_type|
  json.extract! equipment_type, :id, :name, :facility_type_id, :description, :icon, :skill_id, :skill_modifier, :exchange_price
  json.url equipment_type_url(equipment_type, format: :json)
end
