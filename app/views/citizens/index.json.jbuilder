json.array!(@citizens) do |citizen|
  json.extract! citizen, :id, :email, :password, :email_notifications, :daily_updates, :instant_updates, :credits, :home_district_id, :current_profession_id
  json.url citizen_url(citizen, format: :json)
end
