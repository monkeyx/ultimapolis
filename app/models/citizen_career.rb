class CitizenCareer < ActiveRecord::Base
	
	belongs_to :citizen
	belongs_to :profession 
	validates :career_index, numericality: {only_integer: true}
	validates :term_length, numericality: {only_integer: true}
	# t.boolean :current
	
	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :current, -> { where(current: true )}

	default_scope ->{ includes(:profession).order('career_index DESC') }

	def turn_update!
		# TODO
	end
	
end
