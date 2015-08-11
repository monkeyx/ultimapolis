class GlobalEffect < ActiveRecord::Base

	belongs_to :event
	# t.integer :started_on
	# t.integer :expires_on
	# t.boolean :active
	validates :name, presence: true
	# t.text :description
	# t.string :icon
	validates :infrastructure, numericality: {only_integer: true}
	validates :grid, numericality: {only_integer: true}
	validates :power, numericality: {only_integer: true}
	validates :stability, numericality: {only_integer: true}
	validates :climate, numericality: {only_integer: true}
	validates :liberty, numericality: {only_integer: true}
	validates :security, numericality: {only_integer: true}
	validates :borders, numericality: {only_integer: true}
	validates :inflation, numericality: {only_integer: true}

	scope :active, -> { where(active: true )}
	scope :expires_on, ->(turn) { where(expires_on: turn )}

	after_destroy :unapply!

	def to_s
		summary
	end

	def summary
		return @summary.join(', ') if defined?(@summary)
		@summary = []
		if self.infrastructure > 0
			@summary << "Infrastructure upgraded"
		elsif self.infrastructure < 0
			@summary << "Infrastructure degrades"
		end
		if self.grid > 0
			@summary << "Grid upgraded"
		elsif self.grid < 0
			@summary << "Grid deteriotes"
		end
		if self.power > 0
			@summary << "New energy sources discovered"
		elsif self.power < 0
			@summary << "Unknown power drain"
		end
		if self.stability > 0
			@summary << "Stability on the rise"
		elsif self.stability < 0
			@summary << "Instability grips city"
		end
		if self.climate > 0
			@summary << "Climate improves"
		elsif self.climate < 0
			@summary << "Climate worsens"
		end
		if self.liberty > 0
			@summary << "Freedom"
		elsif self.liberty < 0
			@summary << "Tyranny"
		end
		if self.security > 0
			@summary << "Improved security"
		elsif self.security < 0
			@summary << "Decreasing security"
		end
		if self.borders > 0
			@summary << "Borders more secure"
		elsif self.borders < 0
			@summary << "Borders undefended"
		end
		if self.inflation > 0
			@summary << "Inflation"
		elsif self.inflation < 0
			@summary << "Deflation"
		end
		@summary.join(", ")
	end

	def apply!
		transaction do 
			update_attributes!(active: true, started_on: Global.singleton.turn, expires_on: Global.singleton.turn + 60)
			g = Global.singleton
			g.infrastructure += self.infrastructure
			g.grid += self.grid
			g.power += self.power
			g.stability += self.stability
			g.climate += self.climate
			g.liberty += self.liberty
			g.security += self.security
			g.borders += self.borders
			g.inflation += self.inflation
			g.save!
		end
	end

	def unapply!
		if self.active 
			g = Global.singleton
			g.infrastructure -= self.infrastructure
			g.grid -= self.grid
			g.power -= self.power
			g.stability -= self.stability
			g.climate -= self.climate
			g.liberty -= self.liberty
			g.security -= self.security
			g.borders -= self.borders
			g.inflation -= self.inflation
			g.save!
		end
	end

end
