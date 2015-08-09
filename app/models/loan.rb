class Loan < ActiveRecord::Base
	include FinancialProduct

	belongs_to :citizen 
	validates :value, numericality: {only_integer: true }
	validates :interest, numericality: {only_integer: true }
	# t.integer :issued_on
	# t.integer :matures_on

	validate :validate_loan

	before_validation :setup
	after_create :add_credits!
	after_destroy :pay_off_loan!

	def validate_loan
		if new_record?
			unless self.citizen
				errors.add(:citizen, "not valid")
			end
			if self.citizen.maximum_loan < self.value
				errors.add(:value, "is too large")
			end
		end
	end

	def pay_interest!
		self.citizen.update_attributes!(credits: self.citizen.credits - interest_value_per_turn)
	end

	def add_credits!
		self.citizen.update_attributes!(credits: self.citizen.credits + self.value)
	end

	def pay_off_loan!
		self.citizen.update_attributes!(credits: self.citizen.credits - self.total_value)
	end

	def setup
		if new_record?
			self.interest = Global.singleton.interest 
			self.issued_on = Global.singleton.turn 
			self.matures_on = Global::YEAR_OF_TURNS * 5
		end
	end

	def turn_update!
		# TODO
	end
end
