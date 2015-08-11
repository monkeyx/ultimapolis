class CitizenTradeGood < ActiveRecord::Base

	belongs_to :citizen
	belongs_to :trade_good 
	validates :quantity, numericality: {only_integer: true}

	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :for_trade_good, ->(trade_good) { where(trade_good_id: trade_good.id )}

	default_scope ->{ includes(:trade_good).order('trade_goods.name ASC') }

	def to_s
		"#{trade_good} x #{quantity}"
	end

	def value
		return 0 unless self.trade_good
		@value ||= (self.quantity * self.trade_good.exchange_price)
	end
end
