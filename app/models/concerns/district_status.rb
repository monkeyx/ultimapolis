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

	def status_poor_infrastructure?
		Global.singleton.status_poor_infrastructure?
	end

	def status_grid_overpowered?
		Global.singleton.status_grid_overpowered?
	end

	def status_instability?
		Global.singleton.status_instability?
	end

	def status_climate_change?
		Global.singleton.status_climate_change?
	end

	def status_revolution?
		Global.singleton.status_revolution?
	end

	def status_terrorism?
		Global.singleton.status_terrorism?
	end

	def status_invasion?
		Global.singleton.status_invasion?
	end

	def status_power_shortage?
		Global.singleton.status_power_shortage?
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