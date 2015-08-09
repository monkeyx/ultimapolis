class CitizenEquipment < ActiveRecord::Base
	
	belongs_to :citizen
	belongs_to :equipment_type
	validates :quantity, numericality: {only_integer: true}

	default_scope ->{ includes(:equipment_type).order('equipment_types.name ASC') }

	def value
		return 0 unless self.equipment_type
		@value ||= (self.quantity * self.equipment_type.exchange_price)
	end
end
