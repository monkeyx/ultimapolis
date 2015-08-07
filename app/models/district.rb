class District < ActiveRecord::Base

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
			total_land: 100000,
			free_land: 100000,
			transport_capacity: 1000,
			civilians: 1000,
			automatons: 1000,
			unrest: 0,
			health: 50,
			policing: 50,
			social: 25,
			environment: 50,
			housing: 1000,
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
		@free_facility_for_new_citizen ||= (free_land_ratio > 0.5)
	end

	def land_cost
		@land_cost ||= (free_land_ratio == 0 ? -1 : 1000 / free_land_ratio).round(0).to_i
	end

	def free_land_ratio
		@free_land_ratio ||= (total_land == 0 ? 0 : (free_land / total_land))
	end

	def land_usage
		if total_land > 0
			"#{((100 - free_land_ratio * 100)).round(0)}%"
		else
			"N/A"
		end
	end

	def notes
		return @notes if defined?(@notes)
		@notes = []
		return @notes if total_land < 1
		@notes << 'Inadequete public transport' if transport_capacity < civilians
		@notes << "Public disorder" if unrest > 0
		@notes << "Poor public health" if health < 25
		@notes << "Lawlessness" if policing < 25
		@notes << "Urban decay" if social < 25
		@notes << "Homelessness" if housing < civilians
		@notes << "Hazardous environment" if environment < 25
		@notes << "Poor schools" if education < 25
		@notes << "Ethnic tensions" if community < 25
		@notes << "Stifling atmosphere" if creativity < 25
		@notes << "Ugly landscape" if aesthetics < 25
		@notes << "Organised crime" if crime > 25
		@notes << "Corrupt beauracracy" if corruption > 25
		@notes.sort!
		@notes
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
end
