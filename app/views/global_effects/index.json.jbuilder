json.array!(@global_effects) do |global_effect|
  json.extract! global_effect, :id, :event_id, :started_on, :expires_on, :active, :name, :description, :icon
  json.url global_effect_url(global_effect, format: :json)
end
