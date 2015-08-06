json.array!(@district_effects) do |district_effect|
  json.extract! district_effect, :id, :event_id, :started_on, :expires_on, :active, :name, :description, :icon
  json.url district_effect_url(district_effect, format: :json)
end
