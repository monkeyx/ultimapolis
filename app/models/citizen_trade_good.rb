class CitizenTradeGood < ActiveRecord::Base

	belongs_to :citizen
	belongs_to :trade_good 
	validates :quantity, numericality: {only_integer: true}

	default_scope ->{ includes(:trade_good).order('trade_goods.name ASC') }

	def value
		return 0 unless self.trade_good
		@value ||= (self.quantity * self.trade_good.exchange_price)
	end
end
