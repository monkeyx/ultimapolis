module DistrictStatus
	extend ActiveSupport::Concern

	def status_transport_crisis?
		transport_capacity < (civilians - housing)
	end

	def status_disorder?
		unrest > 0
	end

	def status_poor_public_health?
		health < 25
	end

	def status_lawlessness?
		policing < 25
	end

	def status_urban_decay?
		social < 25
	end

	def status_homelessness?
		housing < civilians
	end

	def status_hazardous_environment?
		environment < 25
	end

	def status_poor_schools?
		education < 25
	end

	def status_ethnic_tensions?
		community < 25
	end

	def status_stifling?
		creativity < 25
	end

	def status_ugly?
		aesthetics < 25
	end

	def status_organised_crime?
		crime > 25
	end

	def status_corrupt?
		corruption > 25
	end

	def status_grid_overpowered?
		# TODO
	end

	def status_instability?
		# TODO
	end

	def status_climate_change?
		# TODO
	end

	def status_revolution?
		# TODO
	end

	def status_terrorism?
		# TODO
	end

	def notes
		return @notes if defined?(@notes)
		@notes = []
		return @notes if total_land < 1
		@notes << 'Inadequete public transport' if status_transport_crisis?
		@notes << "Public disorder" if status_disorder?
		@notes << "Poor public health" if status_poor_public_health?
		@notes << "Lawlessness" if status_lawlessness?
		@notes << "Urban decay" if status_urban_decay?
		@notes << "Homelessness" if status_homelessness?
		@notes << "Hazardous environment" if status_hazardous_environment?
		@notes << "Poor schools" if status_poor_schools?
		@notes << "Ethnic tensions" if status_ethnic_tensions?
		@notes << "Stifling atmosphere" if status_stifling?
		@notes << "Ugly landscape" if status_ugly?
		@notes << "Organised crime" if status_organised_crime?
		@notes << "Corrupt beauracracy" if status_corrupt?
		@notes.sort!
		@notes
	end
end