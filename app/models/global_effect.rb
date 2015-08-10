class GlobalEffect < ActiveRecord::Base

	belongs_to :event
	# t.integer :started_on
	# t.integer :expires_on
	# t.boolean :active
	validates :name, presence: true
	# t.text :description
	# t.string :icon
	validates :infrastructure_mod, numericality: {only_integer: true}
	validates :grid_mod, numericality: {only_integer: true}
	validates :power_mod, numericality: {only_integer: true}
	validates :stability_mod, numericality: {only_integer: true}
	validates :climate_mod, numericality: {only_integer: true}
	validates :liberty_mod, numericality: {only_integer: true}
	validates :security_mod, numericality: {only_integer: true}
	validates :borders_mod, numericality: {only_integer: true}
	validates :inflation_mod, numericality: {only_integer: true}

	scope :active, -> { where(active: true )}
	scope :expires_on, ->(turn) { where(expires_on: turn )}

	after_destroy :unapply!

	def apply!
		transaction do 
			update_attributes!(active: true)
			g = Global.singleton
			g.infrastructure += self.inflation_mod
			g.grid += self.grid_mod
			g.power += self.power_mod
			g.stability += self.stability_mod
			g.climate += self.climate_mod
			g.liberty += self.liberty_mod
			g.security += self.security_mod
			g.borders += self.borders_mod
			g.inflation += self.inflation_mod
			g.save!
		end
	end

	def unapply!
		if self.active 
			g = Global.singleton
			g.infrastructure -= self.inflation_mod
			g.grid -= self.grid_mod
			g.power -= self.power_mod
			g.stability -= self.stability_mod
			g.climate -= self.climate_mod
			g.liberty -= self.liberty_mod
			g.security -= self.security_mod
			g.borders -= self.borders_mod
			g.inflation -= self.inflation_mod
			g.save!
		end
	end

end
