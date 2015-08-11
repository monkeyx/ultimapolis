class ExchangeEquipment < ActiveRecord::Base
	
	belongs_to :equipment_type
	belongs_to :citizen 
	validates :turn, numericality: {only_integer: true}
	validates :price, numericality: {only_integer: true}
	validates :quantity, numericality: {only_integer: true}

	validate :validate_exchange

	before_save :set_quantity
	after_create :update_inventory!

	scope :for_item, ->(item) { for_equipment_type(item) }
	scope :for_equipment_type, ->(equipment_type) { where(equipment_type_id: equipment_type.id )}
	scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
	scope :for_turn, ->(turn) { where(turn: turn )}

	attr_accessor :selling

	def validate_exchange
		unless self.citizen 
			errors.add(:citizen, "not set")
			return
		end
		unless self.equipment_type
			errors.add(:equipment_type, "not set")
			return
		end
		if self.selling
			if self.citizen.equipment_count(self.equipment_type) < self.quantity
				errors.add(:quantity, "not available in inventory")
			end
		else
			if self.citizen.credits < (self.quantity * self.equipment_type.exchange_price)
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
			self.citizen.remove_equipment!(self.equipment_type, self.quantity.abs)
			self.citizen.add_credits!((self.quantity * self.equipment_type.exchange_price), "Sold #{self.quantity} x #{self.equipment_type}")
		else
			self.citizen.add_equipment!(self.equipment_type, self.quantity)
			self.citizen.remove_credits!((self.quantity * self.equipment_type.exchange_price), "Bought #{self.quantity} x #{self.equipment_type}")
		end
	end
end
