json.array!(@help_topics) do |help_topic|
  json.extract! help_topic, :id, :name, :body
  json.url help_topic_url(help_topic, format: :json)
end
