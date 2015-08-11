class DistrictEffect < ActiveRecord::Base

	belongs_to :event
	belongs_to :district
	# t.integer :started_on
	# t.integer :expires_on
	# t.boolean :active
	validates :name, presence: true
	# t.text :description
	# t.string :icon
	validates :total_land, numericality: {only_integer: true}
	validates :transport_capacity, numericality: {only_integer: true}
	validates :civilians, numericality: {only_integer: true}
	validates :automatons, numericality: {only_integer: true}
	validates :unrest, numericality: {only_integer: true}
	validates :health, numericality: {only_integer: true}
	validates :policing, numericality: {only_integer: true}
	validates :social, numericality: {only_integer: true}
	validates :environment, numericality: {only_integer: true}
	validates :housing, numericality: {only_integer: true}
	validates :education, numericality: {only_integer: true}
	validates :community, numericality: {only_integer: true}
	validates :creativity, numericality: {only_integer: true}
	validates :aesthetics, numericality: {only_integer: true}
	validates :crime, numericality: {only_integer: true}
	validates :corruption, numericality: {only_integer: true}

	after_destroy :unapply!

	scope :for_district, ->(district) { where(district_id: district.id )}
	scope :active, -> { where(active: true )}
	scope :expires_on, ->(turn) { where(expires_on: turn )}

	def to_s
		summary 
	end

	def summary
		return @summary.join(', ') if defined?(@summary)
		@summary = []
		if self.total_land > 0
			@summary << "Reclaimed land in #{district}"
		elsif self.total_land < 0
			@summary << "Lost and in #{district}"
		end
		if self.transport_capacity > 0
			@summary << "Increased transport capacity in #{district}"
		elsif self.transport_capacity < 0
			@summary << "Transport system broke down in #{district}"
		end
		if self.civilians > 0
			@summary << "Population in #{district} increased"
		elsif self.civilians < 0
			@summary << "Population in #{district} decreased"
		end
		if self.automatons > 0
			@summary << "Increased automation in #{district}"
		elsif self.automatons < 0
			@summary << "Decreased automation in #{district}"
		end
		if self.unrest > 0
			@summary << "Rising unrest in #{district}"
		elsif self.unrest < 0
			@summary << "Situation in #{district} calms down"
		end
		if self.health > 0
			@summary << "Improved public health in #{district}"
		elsif self.health < 0
			@summary << "Public health in #{district} deteriorates"
		end
		if self.policing > 0
			@summary << "Better policing in #{district}"
		elsif self.policing < 0
			@summary << "Lack of law enforcement in #{district}"
		end
		if self.social > 0
			@summary << "Funding for social services in #{district}"
		elsif self.social < 0
			@summary << "Shortage in social services in #{district}"
		end
		if self.environment > 0
			@summary << "Environmental cleanup in #{district}"
		elsif self.environment < 0
			@summary << "Worsening environment in #{district}"
		end
		if self.housing > 0
			@summary << "Expanded social housing in #{district}"
		elsif self.housing < 0
			@summary << "Social housing in #{district} dilapidated"
		end
		if self.education > 0
			@summary << "Improved schools in #{district}"
		elsif self.education < 0
			@summary << "Schools in #{district} run down"
		end
		if self.community > 0
			@summary << "Better community relations in #{district}"
		elsif self.community < 0
			@summary << "Rising tensions in #{district} community"
		end
		if self.creativity > 0
			@summary << "Bohemian atmosphere in #{district}"
		elsif self.creativity < 0
			@summary << "Reactionary attitudes in #{district}"
		end
		if self.aesthetics > 0
			@summary << "Cultural renaissance in #{district}"
		elsif self.aesthetics < 0
			@summary << "Gloom and doom in #{district}"
		end
		if self.crime > 0
			@summary << "Crime on the rise in #{district}"
		elsif self.crime < 0
			@summary << "No tolerance policy pays off in #{district}"
		end
		if self.corruption > 0
			@summary << "Cost of doing business in #{district} increases"
		elsif self.corruption < 0
			@summary << "Honest public servants in #{district}"
		end
		@summary.join(", ")
	end

	def apply!
		transaction do 
			update_attributes!(active: true, started_on: Global.singleton.turn, expires_on: Global.singleton.turn + 60)
			district.total_land += self.total_land
			district.transport_capacity += self.transport_capacity
			district.civilians += self.civilians
			district.automatons += self.automatons
			district.unrest += self.unrest
			district.health += self.health
			district.policing += self.policing
			district.social += self.social
			district.environment += self.environment
			district.housing += self.housing
			district.education += self.education
			district.community += self.community
			district.creativity += self.creativity
			district.aesthetics += self.aesthetics
			district.crime += self.crime
			district.corruption += self.corruption
			self.district.add_report!("#{self}")
		end
	end

	def unapply!
		if self.active
			district.total_land -= self.total_land
			district.transport_capacity -= self.transport_capacity
			district.civilians -= self.civilians
			district.automatons -= self.automatons
			district.unrest -= self.unrest
			district.health -= self.health
			district.policing -= self.policing
			district.social -= self.social
			district.environment -= self.environment
			district.housing -= self.housing
			district.education -= self.education
			district.community -= self.community
			district.creativity -= self.creativity
			district.aesthetics -= self.aesthetics
			district.crime -= self.crime
			district.corruption -= self.corruption
			self.district.add_report!("Effect '#{self}' no longer applies")
		end
	end
end
