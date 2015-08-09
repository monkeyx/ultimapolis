module GlobalStatus
	extend ActiveSupport::Concern

	def status_poor_infrastructure?
		infrastructure < 50
	end

	def status_grid_overpowered?
		grid < 50
	end

	def status_instability?
		stability < 25
	end

	def status_climate_change?
		climate < 50
	end

	def status_revolution?
		liberty < 25
	end

	def status_terrorism?
		security < 75 && (liberty < 50 || liberty > 75) && (stability < 75)
	end

	def status_invasion?
		borders < 50 && security < 75
	end

	def notes
		return @notes if defined?(@notes)
		@notes = []
		@notes << "Poor infrastructure" if status_poor_infrastructure?
		@notes << "Grid black outs" if status_grid_overpowered?
		@notes << "Rioting" if status_instability?
		@notes << "Climate change" if status_climate_change?
		@notes << "Revolution" if status_revolution?
		@notes << "Terrorism" if status_terrorism?
		@notes << "Invasion" if status_invasion?
		@notes
	end
end