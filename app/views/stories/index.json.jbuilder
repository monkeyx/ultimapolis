json.array!(@stories) do |story|
  json.extract! story, :id, :first_node_id, :created_by_id, :name, :active
  json.url story_url(story, format: :json)
end
