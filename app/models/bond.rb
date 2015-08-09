class Bond < ActiveRecord::Base
	include FinancialProduct

	BOND_VALUES = [1000000, 5000000, 10000000, 50000000]

	belongs_to :citizen 
	validates :value, inclusion: {in: BOND_VALUES}
	validates :interest, numericality: {only_integer: true }
	# t.integer :issued_on
	# t.integer :matures_on

	validate :validate_bond

	before_validation :setup
	after_create :deduct_cost!
	after_destroy :return_value!

	def validate_bond
		if new_record?
			unless self.citizen
				errors.add(:citizen, "not valid")
			end
			if self.citizen.credits < self.value
				errors.add(:citizen, "cannot afford bond")
			end
		end
	end

	def pay_interest!
		self.citizen.update_attributes!(credits: self.citizen.credits + interest_value_per_turn)
	end

	def deduct_cost!
		self.citizen.update_attributes!(credits: self.citizen.credits - self.value)
	end

	def return_value!
		self.citizen.update_attributes!(credits: self.citizen.credits + self.value)
	end

	def setup
		if new_record?
			self.interest = Global.singleton.interest 
			self.issued_on = Global.singleton.turn 
			self.matures_on = Global::YEAR_OF_TURNS * 10
		end
	end

	def turn_update!
		# TODO
	end
end
