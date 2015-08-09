class District < ActiveRecord::Base
	include DistrictStatus
	
	validates :name, presence: true
	belongs_to :skill 
	validates :total_land, numericality: {only_integer: true}
	validates :free_land, numericality: {only_integer: true}
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
	# t.text :description
	# t.string :icon

	has_many :district_effects
	has_many :facility_types
	has_many :facilities, through: :facility_types

	scope :has_free_land, ->{ where("free_land > 0")}

	default_scope ->{ order('name ASC') }

	def self.create_new!(name, description, skill, options={})
		options = {
			name: name,
			description: description,
			skill: skill,
			icon: "/icons/districts/#{name.gsub(' ', '_').downcase}.png",
			total_land: 1000,
			free_land: 1000,
			transport_capacity: 500,
			civilians: 0,
			automatons: 0,
			unrest: 0,
			health: 50,
			policing: 50,
			social: 25,
			environment: 50,
			housing: 500,
			education: 50,
			community: 50,
			creativity: 0,
			aesthetics: 10,
			crime: 10,
			corruption: 5
		}.merge!(options)
		create!(options)
	end

	def to_s
		self.name
	end

	def free_facility_for_new_citizen?
		@is_free_facility_for_new_citizen ||= (free_land_ratio > 0.5)
	end

	def land_cost
		@land_cost ||= (free_land_ratio == 0 ? -1 : 1000 / free_land_ratio).round(0).to_i
	end

	def free_land_ratio
		@free_land_ratio ||= (total_land == 0 ? 0 : (free_land.to_f / total_land.to_f))
	end

	def land_usage
		if total_land > 0
			"#{((100 - free_land_ratio * 100)).round(0)}%"
		else
			"N/A"
		end
	end

	def metrics
		return @metrics if defined?(@metrics)
		@metrics = []
		@metrics << ['Population', civilians]
		@metrics << ['Free Land', "#{free_land} / #{total_land}"]
		@metrics << ['Transportation', "#{transport_capacity} / #{civilians}"]
		@metrics << ['Automatons', automatons]
		@metrics << ['Unrest', "#{unrest}%"]
		@metrics << ['Health', "#{health}%"]
		@metrics << ['Policing', "#{policing}%"]
		@metrics << ['Social Cohesion', "#{social}%"]
		@metrics << ['Habitable Environment', "#{environment}%"]
		@metrics << ['Housing', "#{housing} / #{civilians}"]
		@metrics << ['Education', "#{education}%"]
		@metrics << ['Community Services', "#{community}%"]
		@metrics << ['Creative Environment', "#{creativity}%"]
		@metrics << ['Aesthetics', "#{aesthetics}%"]
		@metrics << ['Crime', "#{crime}%"]
		@metrics << ['Corruption', "#{corruption}%"]
		@metrics = @metrics.sort{|a,b| a[0] <=> b[0]}
		@metrics
	end

	def turn_update!
		transaction do
			# TODO Create snapshot
			# Population / automatons
			self.civilians = 0
			self.automatons = 0
			Facility.for_district(self).each do |f|
				self.civilians += (f.facility_type.employees * f.level)
				self.automatons += (f.facility_type.automation * f.level)
			end

			# TODO District effects
			save!
		end
	end
end
