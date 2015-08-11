class CitizenCareer < ActiveRecord::Base
	
	belongs_to :citizen
	belongs_to :profession 
	validates :career_index, numericality: {only_integer: true}
	validates :term_length, numericality: {only_integer: true}
	# t.boolean :current
	
	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :current, -> { where(current: true )}

	default_scope ->{ includes(:profession).order('career_index DESC') }

	after_create :add_start_report!

	def to_s
		"#{profession}"
	end

	def turn_update!
		transaction do
			if rand(100) <= self.term_length # gain rank
				self.citizen.profession_rank += 1
				skill = self.profession.skills.to_a.sample
				self.citizen.add_skill!(skill)
				self.citizen.add_report!("Increased to rank #{self.citizen.profession_rank} in #{self.profession}")
			end
			self.term_length += 1
			save!
			self.citizen.save!
			self.citizen.add_credits!((self.citizen.profession_rank * 100), "#{self.profession} Wages")
		end
	end

	def add_start_report!
		self.citizen.add_report!("Became #{self.profession}")
	end
	
end
