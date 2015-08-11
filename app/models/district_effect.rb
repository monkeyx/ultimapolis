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
		name 
	end

	def summary
		# TODO
	end

	def apply!
		transaction do 
			update_attributes!(active: true, started_on: Global.singleton.turn, expired_on: Global.singleton.turn + 60)
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
			self.district.add_report!("Effect '#{self}' applies")
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
