class ExchangeTradeGood < ActiveRecord::Base

	belongs_to :trade_good
	belongs_to :citizen 
	validates :turn, numericality: {only_integer: true}
	validates :price, numericality: {only_integer: true}
	validates :quantity, numericality: {only_integer: true}

	validate :validate_exchange

	before_save :set_quantity
	after_create :update_inventory!

	scope :for_item, ->(item) { for_trade_good(item) }
	scope :for_trade_good, ->(trade_good) { where(trade_good_id: trade_good.id )}
	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :for_turn, ->(turn) { where(turn: turn )}

	attr_accessor :selling

	def validate_exchange
		unless self.citizen 
			errors.add(:citizen, "not set")
			return
		end
		unless self.trade_good
			errors.add(:trade_good, "not set")
			return
		end
		if self.selling
			if self.citizen.trade_good_count(self.trade_good) < self.quantity
				errors.add(:quantity, "not available in inventory")
			end
		else
			if self.citizen.credits < (self.quantity * self.trade_good.exchange_price)
				errors.add(:quantity, "too expensive to buy")
			end
		end
	end

	def set_quantity
		if self.selling 
			self.quantity = (0 - self.quantity)
		end
	end

	def update_inventory!
		if self.selling 
			self.citizen.remove_trade_good!(self.trade_good, self.quantity.abs)
			self.citizen.add_credits!((self.quantity.abs * self.trade_good.exchange_price), "Sold #{self.quantity.abs} x #{self.trade_good}")
		else
			self.citizen.add_trade_good!(self.trade_good, self.quantity)
			self.citizen.remove_credits!((self.quantity * self.trade_good.exchange_price), "Bought #{self.quantity} x #{self.trade_good}")
		end
	end
end
