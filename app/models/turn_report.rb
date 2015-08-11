class TurnReport < ActiveRecord::Base
	
	validates :turn, numericality: {only_integer: true}
	belongs_to :citizen 
	belongs_to :district 
	validates :summary, presence: true

	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :for_district, ->(district) { where(district_id: district.id )}
	scope :for_turn, ->(turn) { where(turn: turn )}
	scope :for_turn_range, ->(start_turn, end_turn) { where(["turn >= ? AND turn <= ?", start_turn, end_turn ])}
	scope :for_citizen_or_any, ->(citizen) { where(["citizen_id IS NULL OR citizen_id = ?", citizen.id ])}
	scope :district_news, ->(district) { where(["citizen_id IS NULL and district_id = ?", district.id ])}
	scope :global_news, -> { where("citizen_id IS NULL")}

	default_scope ->{ order('created_at DESC') }

	def to_s
		summary
	end
end
