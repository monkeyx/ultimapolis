json.array!(@projects) do |project|
  json.extract! project, :id, :leader_id, :event_id, :began_on, :finished_on, :status, :wages
  json.url project_url(project, format: :json)
end
