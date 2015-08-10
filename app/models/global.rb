class Global < ActiveRecord::Base
	include GlobalStatus

	YEAR_OF_TURNS = 12
	
	validates :infrastructure, numericality: {only_integer: true}
	validates :grid, numericality: {only_integer: true}
	validates :power, numericality: {only_integer: true}
	validates :stability, numericality: {only_integer: true}
	validates :climate, numericality: {only_integer: true}
	validates :liberty, numericality: {only_integer: true}
	validates :security, numericality: {only_integer: true}
	validates :borders, numericality: {only_integer: true}
	validates :turn, numericality: {only_integer: true}
	validates :inflation, numericality: {only_integer: true}
	validates :citizens, numericality: {only_integer: true}
	validates :gdp, numericality: {only_integer: true}
	validates :interest, numericality: {only_integer: true}

	def self.singleton
		Global.first
	end	

	def total_housing
		@total_housing ||= District.all.to_a.sum{|d| d.housing } + Facility.with_facility_types(FacilityType.housing).to_a.sum{|f| f.housing_mod }
	end

	def total_population
		@total_population ||= District.all.to_a.sum{|d| d.civilians }
	end

	def rent_income
		@rent_income ||= (1.5 + (total_population > total_housing ? (total_housing > 0 ? (1 * (total_population.to_f / total_housing.to_f).to_i) : 10 ) : 0 )).round(0).to_i
		@rent_income > 1000 ? 1000 : @rent_income
	end

	def power_generation_income
		@power_generation_income ||= 10 + (power_demand > power_available ? (power_available > 0 ? (10 * (power_demand.to_f / power_available.to_f)).to_i : 50 ) : 0)
		@power_generation_income > 1000 ? 1000 : @power_generation_income
	end

	def power_demand
		@power_demand ||= Facility.with_facility_types(FacilityType.power_consumer).to_a.sum do |f|
			f.level * f.facility_type.power_consumption
		end
	end

	def power_available
		@power_available ||= (self.power * (self.grid / 100.0)).round(0).to_i
	end

	def powered_chance
		return 100 if power_demand < 1 || power_demand < power_available
		((power_available.to_f / power_demand.to_f) * 100).to_i
	end

	def set_gdp
		self.gdp = 0
		Facility.powered.maintained.find_each do |facility|
			self.gdp += facility.gdp_contribution
		end
	end

	def turn_update!
		transaction do
			set_gdp
			GlobalSnapshot.create!(
				infrastructure: infrastructure,
				grid: grid,
				power: power,
				stability: stability,
				climate: climate,
				liberty: liberty,
				security: security,
				borders: borders,
				turn: turn,
				inflation: inflation,
				citizens: citizens,
				gdp: gdp
			)
			self.turn += 1
			# Power
			self.power = 0
			Facility.with_facility_types(FacilityType.power_generator).find_each do |facility|
				self.power += facility.level * facility.facility_type.power_generation
			end
			GlobalEffect.active.expires_on(self.turn).find_each do |effect|
				effect.destroy
			end
			save!
		end
	end

end
