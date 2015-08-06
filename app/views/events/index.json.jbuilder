json.array!(@events) do |event|
  json.extract! event, :id, :name, :event_type, :started_on, :finished_on, :max_duration, :success, :summary, :description, :winning_project_id, :icon
  json.url event_url(event, format: :json)
end
