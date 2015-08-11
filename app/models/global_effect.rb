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
		name
	end

	def summary
		# TODO
	end

	def apply!
		transaction do 
			update_attributes!(active: true, started_on: Global.singleton.turn, expired_on: Global.singleton.turn + 60)
			g = Global.singleton
			g.infrastructure += self.inflation
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
			g.infrastructure -= self.inflation
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
