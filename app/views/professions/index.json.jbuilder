json.array!(@professions) do |profession|
  json.extract! profession, :id, :name, :group
  json.url profession_url(profession, format: :json)
end
