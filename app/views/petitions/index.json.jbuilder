json.array!(@petitions) do |petition|
  json.extract! petition, :id, :citizen_id, :name, :summary, :accepted, :turn, :cached_votes_up, :cached_votes_down, :cached_votes_total, :cached_votes_score, :cached_weighted_score, :cached_weighted_total, :cached_weighted_average
  json.url petition_url(petition, format: :json)
end
