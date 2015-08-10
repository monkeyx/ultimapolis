module FinancialProduct
	extend ActiveSupport::Concern

	def turn_remaining
		@turn_remaining ||= self.matures_on - Global.singleton.turn
	end

	def interest_value_per_turn
		@interest_value_per_turn ||= (self.value * (self.interest / 100.0)).round(0).to_i
	end

	def total_value
		return @total if defined?(@total)
		@total = self.value
		turn_remaining.times do |n|
			@total += interest_value_per_turn
		end	
		@total
	end

	def matures?
		self.matures_on == Global.singleton.turn 
	end
end